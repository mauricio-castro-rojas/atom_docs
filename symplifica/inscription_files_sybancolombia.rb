Preguntas edi:
Los bancos tienen códigos generados desde los seeds en sypay, yo utilicé esos seeds para  meter los códgios en la base de datos local
pero como debería funcionar para producción.

Los tipos de cuenta tambien se generan desde los seeds, en sypay. Como es para las tarjetas de credito -> no se manejan creditos


popular_bank = ::SyPay::Bank.find_by(name:'BANCO POPULAR')
colombia = ::SyMaps::GeoFence::Country.find_by(name: 'Colombia')

#GATEWAY BANCOLOMBIA
gateway_bancolombia = ::SyPayCo::Gateway::Bancolombia.create!(name:'BANCOLOMBIA', is_active:true, credentials_key:'GATEWAY_BANCOLOMBIA')
gateway_bancolombia.countries << [colombia]
abstract_gateway_bancolombia= ::SyPay::Gateway.create!(gateway: gateway_bancolombia, is_active: true)


# Cuentas bancarias
# Tipos
savings_account_bank_kind = ::SyPay::PaymentMethod::AccountBank::Kind.find_by(name: 'savings')
regular_account_bank_kind = ::SyPay::PaymentMethod::AccountBank::Kind.find_by(name: 'regular')

employer1 = Employer.find_by_email('employer_a@mail.com')

=begin
account_holder1 = ::SyPay::AccountHolder.new(
  name: "paysEmployer1",
  document_type: :citizenship_card,
  document_number: Faker::Number.number.to_s
)
account_holder1.save!
account_holder1.reload
=end

account_number = Faker::Bank.account_number
bank_account1 = ::SyPay::PaymentMethod::AccountBank.new(
  number: account_number,
  bank: popular_bank,
  kind: savings_account_bank_kind,
  mask: account_number.chars.last(4).join,
  creator: employer1
)
bank_account1.save!
bank_account1.reload

# Payment method abstract
payment_method1 = ::SyPay::PaymentMethod.new(
  holder: employer1,
  creator: employer1,
  is_main_payment_method: false,
  status: :active,
  payment_method: bank_account1
)

payment_method1.save!
payment_method1.reload

# Payment Method Inscription
payment_method_inscription1 = ::SyPay::PaymentMethod::Inscription.new(
  payment_method: payment_method1,
  gateway: abstract_gateway_bancolombia,
  kind: :collection,
  expired_date: Time.now + 3.year,
  state: :created
)
payment_method_inscription1.save!
payment_method_inscription1.reload

#<SyPay::PaymentMethod::Inscription:0x00007fa82dd1df80
 id: 15,
 payment_method_type: "SyPay::PaymentMethod",
 payment_method_id: 14,
 gateway_id: 6,
 kind: "collection",
 inscription_token: "2022102615",
 expired_date: Sun, 26 Oct 2025 04:55:22.118972000 -05 -05:00,
 state: "created",
 rejected_message: nil,
 slug: "7abe574b-eec6-4967-bd2a-b981fb5f15e4",
 token: "7abe574b-eec6-4967-bd2a-b981fb5f15e4",
 public_token: "c2d0f9c0-0d26-4958-bbed-28e288f754c1",
 created_at: Wed, 26 Oct 2022 04:55:22.149863000 -05 -05:00,
 updated_at: Wed, 26 Oct 2022 04:55:22.158960000 -05 -05:00,
 discarded_at: nil,
 log_data: nil

inscription = SyPay::PaymentMethod::Inscription.find(15)
collection_inscription_payment = ::SyBancolombia::Collection::Inscription::Payment.new(kind: 23)
inscription_payment = ::SyBancolombia::Inscription::Payment.new(
      inscription: inscription,
      delegated_inscription: collection_inscription_payment
    )


collection_inscription_payment.save!
inscription_payment.save!



----------------------------------------------------------------------------------------------------------------------------------------

Responses


Preguntas edi:
1. jobs de procesamiento y jobs de reader, cómo se relacionan

2. inscription token de un pminscription cómo se llena?

3. inscription token row toma valores distintos al a validacion, para que es este token o como se utiliza

4. Registro de encabezado de archivo, de lote, control de lote y control de archivo hay que procesarlo o hacer validaciones?

5. Registro de detalle, campo 14 fer me paso un archivo con los codigos de respuesta asobancaria

6. como funcionan estos:
# :nocov:
module SyBancolombia::Collection::Inscription::Payment::Response::File

  #===== Constants
  MACRO_REJECTION_CODES = {
    #success: '0000'
  }

  STATUSES_BANK = {
    #success: 'Aceptado',
    # pending: 'Pendiente respuesta otros banc'
  }

end

#sy app admin archivo que sube laura
response_file = ::SyDavivienda::Collection::Inscription::Payment::Response.create!(
        file: file_io
      )

::SyPayCo::Collection::Inscription::Payment::Response::File::Davivienda::ReadJob.perform_later(response_file)

#seeds

collection_inscriptions_davivienda_file = ::SyDavivienda::Collection::Inscription::Payment::File.last.file

response_inscription_dummy = {
  payment_method_inscription6.inscription_token => '0000Aceptado                                                    ',
  payment_method_inscription7.inscription_token => '0000Pendiente respuesta otros banc                              ',
  payment_method_inscription8.inscription_token => 'N905Producto No Inscrito                                        '
}

path_collection_inscriptions_davivienda_file_response = ::SyPayCo::Engine.root.join('db', 'seeds', 'files', 'collection_inscriptions_davivienda_file_response.txt')
FileUtils.mkdir_p path_collection_inscriptions_davivienda_file_response.dirname
collection_inscriptions_davivienda_file.open do |tempfile|
  File.open(path_collection_inscriptions_davivienda_file_response, 'wb') do |f|
    IO.foreach(tempfile) do |line|
      inscription_token_row = line[(reference_code_metadata[:column][:start] - 1)..(reference_code_metadata[:column][:end] - 1)].to_i.to_s
      raise 'Error: Add inscription response on hash "response_inscription_dummy" for inscription with inscription token "inscription_token_row"' unless response_inscription_dummy[inscription_token_row]
      f.puts("#{line.chomp}#{response_inscription_dummy[inscription_token_row]}")
    end
  end
end

sy_davivienda_collection_inscription_payment_response = ::SyDavivienda::Collection::Inscription::Payment::Response.new
sy_davivienda_collection_inscription_payment_response.file.attach(
  io: File.open(path_collection_inscriptions_davivienda_file_response),
  filename: 'collection_inscriptions_davivienda_file_response.txt',
  content_type: 'text/plain',
  identify: false
)
sy_davivienda_collection_inscription_payment_response.save!

::SyPayCo::Collection::Inscription::Payment::Response::File::Davivienda::ReadJob.perform_now(sy_davivienda_collection_inscription_payment_response)

puts '      #### Process responses'
::SyPayCo::Collection::Inscription::Payment::Response::Davivienda::ProcessJob.perform_now(later: false)


----------------------------------------------------------------------------------------------------------------------------------------

SFTP

1. Inscripciones carga y descarga

2. Pagos (dispersion) carga y descarga

3. Recaudo carga y descarga SyBancolombia::Transaction::Payment > SyBancolombia::Collection::Transaction (recomendado por edi)


Archivo xlsx entrada asobancaria 2011con val

Tab de input es debito o recaudo



Preguntas BANCOLOMBIA
1. El archivo input que en español esta como entrada facturación tiene diferencias en cuanto los codigos de respuesta, estos son obligatorios
de validación ? es decir bancolombia los valida siempre y entrega respuesta?

2.El modificador de archivo es obligatorio para recaudos debe ser secuencial es decir creamos el archivo A a las 10 am y luego a las 11 am creamos el archivo
B,

En el caso que solo mandemos uno en un mismo dia sería solo A
Validation
That the Batch Sequence are not blanks. 

3. REcaudos Batch record > Batch Number> Description: Batch consecutive within the file. Each file has its own batch numbering sequence.


----------------------------------------------------------------------------------------------------------------------------------------
