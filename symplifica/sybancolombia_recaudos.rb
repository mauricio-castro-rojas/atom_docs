llamar al job de lectura
guardar el archivo de respuesta en syapp
response_text_file = File.new('inscription_response.txt', File::RDONLY)
#inscription response debe estar en la carpeta de syapp
sy_bancolombia_response_object = ::SyBancolombia::Collection::Inscription::Payment::Response.create!(
  file: response_text_file
)
file_io.close
::SyPayCo::Collection::Inscription::Payment::Response::File::Bancolombia::ReadJob.perform_now(response_file)




  ------
  seeds de recaudos
  # RecolecciÃ³n por davivienda
colombia = ::SyMaps::GeoFence::Country.find_by(name: 'Colombia')

popular_bank = ::SyPay::Bank.find_by(name:'BANCO POPULAR')
bancolombia_bank = ::SyPay::Bank.find_by(name:'BANCOLOMBIA S.A.')
scotiabank_bank = ::SyPay::Bank.find_by(name: 'SCOTIABANK COLPATRIA S.A.')
caja_social_bank = ::SyPay::Bank.find_by(name:'BANCO CAJA SOCIAL - BCSC S.A.')
bogota_bank = ::SyPay::Bank.find_by(name:'BANCO DE BOGOTÁ')

banks = [popular_bank, bancolombia_bank , scotiabank_bank,caja_social_bank,bogota_bank]
gateway_bancolombia = ::SyPayCo::Gateway::Bancolombia.create!(name:'BANCOLOMBIA', is_active:true, credentials_key:'GATEWAY_BANCOLOMBIA')
gateway_bancolombia.countries << [colombia]
abstract_gateway_bancolombia= ::SyPay::Gateway.create!(gateway: gateway_bancolombia, is_active: true)

savings_account_bank_kind = ::SyPay::PaymentMethod::AccountBank::Kind.find_by(name: 'savings')
regular_account_bank_kind = ::SyPay::PaymentMethod::AccountBank::Kind.find_by(name: 'regular')
kinds = [savings_account_bank_kind,regular_account_bank_kind]
employer1 = Employer.find_by_email('employer_a@mail.com')
employer2 = Employer.find_by_email('employer_b@mail.com')
employer3 = Employer.find_by_email('daniela.calvano@symplifica.com')

employers = [ employer1, employer2, employer3 ]

  account_number = Faker::Bank.account_number
  bank = banks.shuffle.first
  employer = employers.shuffle.first
  kind = kinds.shuffle.first
  bank_account = ::SyPay::PaymentMethod::AccountBank.new(
    number: account_number,
    bank: bank,
    kind: kind,
    mask: account_number.chars.last(4).join,
    creator: employer
  )
  bank_account.save!
  bank_account.reload

  payment_method = ::SyPay::PaymentMethod.new(
    holder: employer,
    creator: employer,
    is_main_payment_method: false,
    status: :active,
    payment_method: bank_account
  )
  payment_method.save!
  payment_method.reload

  payment_method_inscription = ::SyPay::PaymentMethod::Inscription.new(
    payment_method: payment_method,
    gateway: abstract_gateway_bancolombia,
    kind: :collection,
    expired_date: Time.now + 3.year,
    state: :created
  )
  payment_method_inscription.save!
  payment_method_inscription.reload
  amount = rand(50_000_00..1_000_000_00)
  order = ::SyPay::Order.create!(
    owner: employer,
    code: SecureRandom.hex(10),
    due_date: Date.current - 5.days,
    amount: Money.new(amount, "COP")
  )
  raise 'Incorrect Status for order' unless order.reload.status.to_sym == :created

  puts '  ###### Order Items'
  payroll1 = order.order_items.create!(item: employer.contracts.first.payrolls.first, amount: Money.new(rand(50_000_00..200_000_00), "COP"))
  raise 'Incorrect Status for order1' unless order.reload.status.to_sym == :created
  raise 'Incorrect Status for payroll1' unless payroll1.item.reload.payment_state.to_sym == :pending

  payroll2 = order.order_items.create!(item: employer.contracts.first.payrolls.second, amount: Money.new(rand(50_000_00..200_000_00), "COP"))
  raise 'Incorrect Status for payroll2' unless payroll2.item.reload.payment_state.to_sym == :pending

  pila1 = order.order_items.create!(item: employer.contracts.first.pilas.first, amount: Money.new(rand(50_000_00..200_000_00), "COP"))
  raise 'Incorrect Status for order1' unless order.reload.status.to_sym == :created
  raise 'Incorrect Status for pila1_order_item_order1 SyPilaCo::Pila' unless pila1.item.reload.payment_state.to_sym == :pending

  pila2 = order.order_items.create!(item: employer.contracts.first.pilas.second, amount: Money.new(rand(50_000_00..200_000_00), "COP"))
  raise 'Incorrect Status for order1' unless order.reload.status.to_sym == :created
  raise 'Incorrect Status for pila2_order_item_order1 SyPilaCo::Pila' unless pila2.item.reload.payment_state.to_sym == :pending

  semiannual_bonus = order.order_items.create!(item: employer.contracts.first.semiannual_bonuses.first, amount: Money.new(rand(50_000_00..200_000_00), "COP"))
  raise 'Incorrect Status for order1' unless order.reload.status.to_sym == :created
  raise 'Incorrect Status for semiannual_bonus' unless semiannual_bonus.item.reload.payment_status.to_sym == :pending

  affiliation_link = ::SyPay::Products::Affiliation::Link::Contract.create!(
    contract: ::SyRegistryCo::Contract.first,
    product: ::SyPay::Products::Affiliation.all.sample
  )

  affiliation_order_item = order.order_items.create!(item: affiliation_link, amount: Money.new(rand(50_000_00..200_000_00), "COP"))
  raise 'Incorrect Status for order1' unless order.reload.status.to_sym == :created

  service = ::SyPay::Service.create!(
    plan: ::SyPay::Products::Plan.first,
    contract: ::SyRegistryCo::Contract.first,
    start_date: Date.current - 5.days,
    end_date: Date.current + 5.days,
    amount_cents: 12774800,
    kind: :fee_prorate
  )
  service_order_item = order.order_items.create!(item: service, amount: Money.new(rand(50_000_00..200_000_00), "COP"))
  raise 'Incorrect Status for order1' unless order.reload.status.to_sym == :created

  transaction_cost_order_item = order.order_items.create!(item: ::SyPay::Products::TransactionCost.find(1), amount: Money.new(5_900_00, "COP"))
  raise 'Incorrect Status for order1' unless order.reload.status.to_sym == :created


  transaction_order = ::SyPay::Transaction.create!(
    payment_method_inscription: payment_method_inscription,
    kind: :collection,
    amount: order.amount
  )
  transaction_order.paid! # Need for active callback after update commit
  raise 'Incorrect Status for order1' unless order.reload.status.to_sym == :created

  transaction_order.order_items << payroll1
  raise 'Incorrect Status for order1' unless order.reload.status.to_sym == :paid
  raise 'Incorrect Status for transaction linkeable payroll1_order_item_order1' unless payroll1.item.reload.payment_state.to_sym == :collected

  transaction_order.order_items << payroll2
  raise 'Incorrect Status for order1' unless order.reload.status.to_sym == :paid
  raise 'Incorrect Status for transaction linkeable payroll2_order_item_order1' unless payroll2.item.reload.payment_state.to_sym == :collected

  transaction_order.order_items << pila1
  raise 'Incorrect Status for order1' unless order.reload.status.to_sym == :paid
  raise 'Incorrect Status for transaction linkeable pila1_order_item_order1' unless pila1.item.reload.payment_state.to_sym == :collected

  transaction_order.order_items << pila2
  raise 'Incorrect Status for order1' unless order.reload.status.to_sym == :paid
  raise 'Incorrect Status for transaction linkeable pila2_order_item_order1' unless pila2.item.reload.payment_state.to_sym == :collected

  transaction_order.order_items << semiannual_bonus
  raise 'Incorrect Status for order1' unless order.reload.status.to_sym == :paid
  raise 'Incorrect Status for transaction linkeable semiannual_bonus_order_item_order1' unless semiannual_bonus.item.reload.payment_status.to_sym == :collected


  transaction_order.order_items << [affiliation_order_item,
                                      service_order_item,
                                      transaction_cost_order_item]

  collection_transaction_order = ::SyBancolombia::Collection::Transaction::Payment.create!
  ::SyBancolombia::Transaction::Payment.create! _transaction: transaction_order, delegated_transaction: collection_transaction_order



::SyPay::Transaction
      .joins(payment_method_inscription: :gateway)
      .where(
        #state: :created,
        kind: :collection,
        gateway: { gateway_type: SyPayCo::Gateway::Bancolombia.name }
      ).each {|t| t.created!}

transaction_job = ::SyPayCo::Collection::Transaction::Payment::File::Bancolombia::GenerateJob.perform_now

file created:

#<SyBancolombia::Collection::Transaction::Payment::File:0x00007fd1390bf650
 id: 4,
 process_code: nil,
 status: "created",
 last_download_date: nil,
 slug: "6ed10200-a31a-44f4-8c1b-40510e42cdf0",
 token: "6ed10200-a31a-44f4-8c1b-40510e42cdf0",
 public_token: "788942f3-23c7-405d-b59c-3df020ee91e3",
 discarded_at: nil,
 created_at: Tue, 01 Nov 2022 11:20:46.714807000 -05 -05:00,
 updated_at: Tue, 01 Nov 2022 11:20:46.726582000 -05 -05:00,
 modifier: "C",
 log_data: nil>

 #download file:
 transaction_payment_file = SyBancolombia::Collection::Transaction::Payment::File.find(4).file
 path_collection_transactions = ::SyPayCo::Engine.root.join('db', 'seeds', 'bancolombia_files', 'transactions_test.txt')
 File.open(path_collection_transactions, 'wb') do |f|
   f.write(transaction_payment_file.download)
 end
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
#manually creation of collection transaction payment

file=::SyBancolombia::Collection::Transaction::Payment::File.new(modifier: 'A')
text = "TEXT FILE 1111"

File.write('t.txt', text)

f1 = File.new('t.txt', File::RDWR)

file.file.attach(
     io: f1,
     filename: "#{Time.now.strftime('%Y%m%d%H%M%S.txt')}"
   )
file.save!
f1.close

sy_bancolombia_collection_transaction1_order1 = ::SyBancolombia::Collection::Transaction::Payment.create!(file: file)
::SyBancolombia::Transaction::Payment.create! _transaction: transaction1_order1, delegated_transaction: sy_bancolombia_collection_transaction1_order1
transaction1_order1.created!

::SyPayCo::Collection::Transaction::Payment::File::Bancolombia::GenerateJob.perform_now


#<SyBancolombia::Collection::Transaction::Payment::File::Generator:0x00007faa3d86ff30
 @file_register_in_header={:tax_identification_number_company=>"9008628317", :generation_date=>"20221028", :generation_hour=>"1541"},
 @transactions_payments=
  [{:user_main_reference=>"11",
    :holder_document_id_number=>"79787598",
    :main_service_value=>75790000,
    :expiration_date=>Fri, 28 Oct 2022 15:41:08.988639000 -05 -05:00,
    :sequence=>"11"}]>

    #inscripciones que se mapean al gateway para el generate job de inscripciones
    ::SyPay::PaymentMethod::Inscription
          .joins(:gateway)
          .where(
            state: :created,
            kind: :collection,
            gateway: { gateway_type: SyPayCo::Gateway::Bancolombia.name }
          )



--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------


script to execute response file for inscription  reader job

path = ::SyPayCo::Engine.root.join('db', 'seeds', 'bancolombia_files', 'collection_inscription_response.txt')
#we should put that file on that directory first

collection_inscription_payment_response = ::SyBancolombia::Collection::Inscription::Payment::Response.new
collection_inscription_payment_response.file.attach(
  io: File.open(path),
  filename: 'collection_inscription_response.txt',
  content_type: 'text/plain',
  identify: false
)
collection_inscription_payment_response.save!

::SyPayCo::Collection::Inscription::Payment::Response::File::Bancolombia::ReadJob.perform_now(collection_inscription_payment_response)
