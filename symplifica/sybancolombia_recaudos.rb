llamar al job de lectura
guardar el archivo de respuesta en syapp
file_io = File.new('inscription_response.txt', File::RDWR)
      response_file = ::SyBancolombia::Collection::Inscription::Payment::Response.create!(
        file: file_io
      )
file_io.close
::SyPayCo::Collection::Inscription::Payment::Response::File::Bancolombia::ReadJob.perform_now(response_file)




  ------
  seeds de recaudos

  # RecolecciÃ³n por davivienda
colombia = ::SyMaps::GeoFence::Country.find_by(name: 'Colombia')

scotiabank_bank = ::SyPay::Bank.find_by(name: 'SCOTIABANK COLPATRIA S.A.')

gateway_bancolombia = ::SyPayCo::Gateway::Bancolombia.create!(name:'BANCOLOMBIA', is_active:true, credentials_key:'GATEWAY_BANCOLOMBIA')
gateway_bancolombia.countries << [colombia]
abstract_gateway_bancolombia= ::SyPay::Gateway.create!(gateway: gateway_bancolombia, is_active: true)

savings_account_bank_kind = ::SyPay::PaymentMethod::AccountBank::Kind.find_by(name: 'savings')

employer1 = Employer.find_by_email('employer_a@mail.com')

  puts '      ### Account Bank 6'
# Omar Perdomo Ospina
account_number = Faker::Bank.account_number
bank_account6 = ::SyPay::PaymentMethod::AccountBank.new(
  number: account_number,
  bank: scotiabank_bank,
  kind: savings_account_bank_kind,
  mask: account_number.chars.last(4).join,
  creator: employer1
)
bank_account6.save!
bank_account6.reload

# Payment method abstract
payment_method6 = ::SyPay::PaymentMethod.new(
  holder: employer1,
  creator: employer1,
  is_main_payment_method: false,
  status: :active,
  payment_method: bank_account6
)
payment_method6.save!
payment_method6.reload

payment_method_inscription6 = ::SyPay::PaymentMethod::Inscription.new(
  payment_method: payment_method6,
  gateway: abstract_gateway_bancolombia,
  kind: :collection,
  expired_date: Time.now + 3.year,
  state: :created
)
payment_method_inscription6.save!
payment_method_inscription6.reload

order1 = ::SyPay::Order.create!(
  owner: employer1,
  code: SecureRandom.hex(10),
  due_date: Date.current - 5.days,
  amount: Money.new(757_900_00, "COP")
)
puts '    # Collection Transaction'
transaction1_order1 = ::SyPay::Transaction.create!(
  payment_method_inscription: payment_method_inscription6,
  kind: :collection,
  amount: order1.amount
)
transaction1_order1.paid! # Need for active callback after update commit

raise 'Incorrect Status for order1' unless order1.reload.status.to_sym == :created
payroll1_order_item_order1 = order1.order_items.create!(item: employer1.contracts.first.payrolls.first, amount: Money.new(100_000_00, "COP"))
payroll2_order_item_order1 = order1.order_items.create!(item: employer1.contracts.first.payrolls.second, amount: Money.new(110_000_00, "COP")) # 210.000
pila1_order_item_order1 = order1.order_items.create!(item: employer1.contracts.first.pilas.first, amount: Money.new(200_000_00, "COP")) # 410.000
pila2_order_item_order1 = order1.order_items.create!(item: employer1.contracts.first.pilas.second, amount: Money.new(230_000_00, "COP")) # 640.000
semiannual_bonus_order_item_order1 = order1.order_items.create!(item: employer1.contracts.first.semiannual_bonuses.first, amount: Money.new(50_000_00, "COP")) # 640.000
affiliation_link = ::SyPay::Products::Affiliation::Link::Contract.create!(
  contract: ::SyRegistryCo::Contract.first,
  product: ::SyPay::Products::Affiliation.all.sample
)
affiliation_order_item_order1 = order1.order_items.create!(item: affiliation_link, amount: Money.new(76_000_00, "COP")) # 716.000
service = ::SyPay::Service.create!(
  plan: ::SyPay::Products::Plan.first,
  contract: ::SyRegistryCo::Contract.first,
  start_date: Date.current - 5.days,
  end_date: Date.current + 5.days,
  amount_cents: 12774800,
  kind: :fee_prorate
)
service_order_item_order1 = order1.order_items.create!(item: service, amount: Money.new(36_000_00, "COP"))
transaction_cost_order_item_order1 = order1.order_items.create!(item: ::SyPay::Products::TransactionCost.find(1), amount: Money.new(5_900_00, "COP"))


transaction1_order1.order_items << payroll1_order_item_order1
payroll1_order_item_order1.item.collected!
raise 'Incorrect Status for order1' unless order1.reload.status.to_sym == :paid
raise 'Incorrect Status for transaction linkeable payroll1_order_item_order1' unless payroll1_order_item_order1.item.reload.payment_state.to_sym == :collected

transaction1_order1.order_items << payroll2_order_item_order1
payroll2_order_item_order1.item.collected!
raise 'Incorrect Status for order1' unless order1.reload.status.to_sym == :paid
raise 'Incorrect Status for transaction linkeable payroll2_order_item_order1' unless payroll2_order_item_order1.item.reload.payment_state.to_sym == :collected

transaction1_order1.order_items << pila1_order_item_order1
pila1_order_item_order1.item.collected!
raise 'Incorrect Status for order1' unless order1.reload.status.to_sym == :paid
raise 'Incorrect Status for transaction linkeable pila1_order_item_order1' unless pila1_order_item_order1.item.reload.payment_state.to_sym == :collected

transaction1_order1.order_items << pila2_order_item_order1
pila2_order_item_order1.item.collected!
raise 'Incorrect Status for order1' unless order1.reload.status.to_sym == :paid
raise 'Incorrect Status for transaction linkeable pila2_order_item_order1' unless pila2_order_item_order1.item.reload.payment_state.to_sym == :collected

transaction1_order1.order_items << semiannual_bonus_order_item_order1
semiannual_bonus_order_item_order1.item.collected!
raise 'Incorrect Status for order1' unless order1.reload.status.to_sym == :paid
raise 'Incorrect Status for transaction linkeable semiannual_bonus_order_item_order1' unless semiannual_bonus_order_item_order1.item.reload.payment_status.to_sym == :collected
semiannual_bonus_order_item_order1.item.collected!

transaction1_order1.order_items << [affiliation_order_item_order1,
                                    service_order_item_order1,
                                    transaction_cost_order_item_order1]
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
