#script to load collection inscriptions to database and create file
popular_bank = ::SyPay::Bank.find_by(name:'BANCO POPULAR')
bancolombia_bank = ::SyPay::Bank.find_by(name:'BANCOLOMBIA S.A.')
scotiabank_bank = ::SyPay::Bank.find_by(name: 'SCOTIABANK COLPATRIA S.A.')
caja_social_bank = ::SyPay::Bank.find_by(name:'BANCO CAJA SOCIAL - BCSC S.A.')
bogota_bank = ::SyPay::Bank.find_by(name:'BANCO DE BOGOTÁ')

colombia = ::SyMaps::GeoFence::Country.find_by(name: 'Colombia')

#GATEWAY BANCOLOMBIA
concret_gateway_bancolombia = ::SyPayCo::Gateway::Bancolombia.create!(name:'BANCOLOMBIA', is_active:true, credentials_key:'GATEWAY_BANCOLOMBIA')
concret_gateway_bancolombia.countries << [colombia]
abstract_gateway_bancolombia= ::SyPay::Gateway.create!(gateway: concret_gateway_bancolombia, is_active: true)
# Cuentas bancarias
# Tipos
savings_account_bank_kind = ::SyPay::PaymentMethod::AccountBank::Kind.find_by(name: 'savings')
regular_account_bank_kind = ::SyPay::PaymentMethod::AccountBank::Kind.find_by(name: 'regular')
#employers
employer1 = Employer.find_by_email('employer_a@mail.com')
employer2 = Employer.find_by_email('employer_b@mail.com')
#bank accounts

#-----------------------------------------------------------
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

#-----------------------------------------------------------
account_number = Faker::Bank.account_number
bank_account2 = ::SyPay::PaymentMethod::AccountBank.new(
  number: account_number,
  bank: bancolombia_bank,
  kind: regular_account_bank_kind,
  mask: account_number.chars.last(4).join,
  creator: employer2
)
bank_account2.save!
bank_account2.reload
#-----------------------------------------------------------
account_number = Faker::Bank.account_number
bank_account3 = ::SyPay::PaymentMethod::AccountBank.new(
  number: account_number,
  bank: scotiabank_bank,
  kind: savings_account_bank_kind,
  mask: account_number.chars.last(4).join,
  creator: employer1
)
bank_account3.save!
bank_account3.reload
#-----------------------------------------------------------
account_number = Faker::Bank.account_number
bank_account4 = ::SyPay::PaymentMethod::AccountBank.new(
  number: account_number,
  bank: caja_social_bank,
  kind: regular_account_bank_kind,
  mask: account_number.chars.last(4).join,
  creator: employer1
)
bank_account4.save!
bank_account4.reload
#-----------------------------------------------------------
account_number = Faker::Bank.account_number
bank_account5 = ::SyPay::PaymentMethod::AccountBank.new(
  number: account_number,
  bank: bogota_bank,
  kind: savings_account_bank_kind,
  mask: account_number.chars.last(4).join,
  creator: employer1
)
bank_account5.save!
bank_account5.reload
#-----------------------------------------------------------
account_number = Faker::Bank.account_number
bank_account6 = ::SyPay::PaymentMethod::AccountBank.new(
  number: account_number,
  bank: bancolombia_bank,
  kind: regular_account_bank_kind,
  mask: account_number.chars.last(4).join,
  creator: employer1
)
bank_account6.save!
bank_account6.reload


#-----------------------------------------------------------
#-----------------------------------------------------------
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
#-----------------------------------------------------------
# Payment method abstract
payment_method2 = ::SyPay::PaymentMethod.new(
  holder: employer2,
  creator: employer2,
  is_main_payment_method: false,
  status: :active,
  payment_method: bank_account1
)

payment_method2.save!
payment_method2.reload
#-----------------------------------------------------------
# Payment method abstract
payment_method3 = ::SyPay::PaymentMethod.new(
  holder: employer1,
  creator: employer1,
  is_main_payment_method: false,
  status: :active,
  payment_method: bank_account3
)

payment_method3.save!
payment_method3.reload
#-----------------------------------------------------------
# Payment method abstract
payment_method4 = ::SyPay::PaymentMethod.new(
  holder: employer2,
  creator: employer2,
  is_main_payment_method: false,
  status: :active,
  payment_method: bank_account4
)

payment_method4.save!
payment_method4.reload
#-----------------------------------------------------------
# Payment method abstract
payment_method5 = ::SyPay::PaymentMethod.new(
  holder: employer1,
  creator: employer1,
  is_main_payment_method: false,
  status: :active,
  payment_method: bank_account5
)

payment_method5.save!
payment_method5.reload
#-----------------------------------------------------------
# Payment method abstract
payment_method6 = ::SyPay::PaymentMethod.new(
  holder: employer2,
  creator: employer2,
  is_main_payment_method: false,
  status: :active,
  payment_method: bank_account6
)

payment_method6.save!
payment_method6.reload

#-----------------------------------------------------------
#-----------------------------------------------------------

#-----------------------------------------------------------
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
#-----------------------------------------------------------
# Payment Method Inscription
payment_method_inscription2 = ::SyPay::PaymentMethod::Inscription.new(
  payment_method: payment_method2,
  gateway: abstract_gateway_bancolombia,
  kind: :collection,
  expired_date: Time.now + 3.year,
  state: :created
)
payment_method_inscription2.save!
payment_method_inscription2.reload
#-----------------------------------------------------------
# Payment Method Inscription
payment_method_inscription3 = ::SyPay::PaymentMethod::Inscription.new(
  payment_method: payment_method3,
  gateway: abstract_gateway_bancolombia,
  kind: :collection,
  expired_date: Time.now + 3.year,
  state: :created
)
payment_method_inscription3.save!
payment_method_inscription3.reload
#-----------------------------------------------------------
# Payment Method Inscription
payment_method_inscription4 = ::SyPay::PaymentMethod::Inscription.new(
  payment_method: payment_method4,
  gateway: abstract_gateway_bancolombia,
  kind: :collection,
  expired_date: Time.now + 3.year,
  state: :created
)
payment_method_inscription4.save!
payment_method_inscription4.reload
#-----------------------------------------------------------
# Payment Method Inscription
payment_method_inscription5 = ::SyPay::PaymentMethod::Inscription.new(
  payment_method: payment_method5,
  gateway: abstract_gateway_bancolombia,
  kind: :collection,
  expired_date: Time.now + 3.year,
  state: :created
)
payment_method_inscription5.save!
payment_method_inscription5.reload
#-----------------------------------------------------------
# Payment Method Inscription
payment_method_inscription6 = ::SyPay::PaymentMethod::Inscription.new(
  payment_method: payment_method6,
  gateway: abstract_gateway_bancolombia,
  kind: :collection,
  expired_date: Time.now + 3.year,
  state: :created
)
payment_method_inscription6.save!
payment_method_inscription6.reload

SyPayCo::Collection::Inscription::Payment::File::Bancolombia::GenerateJob.perform_now

#the job changes the state of all the payment methods inscriptions so to retry:
:SyPay::PaymentMethod::Inscription
.joins(:gateway)
.where(
  kind: :collection,
  gateway: { gateway_type: SyPayCo::Gateway::Bancolombia.name }
).each { |i| i.created! }


# okay result:

(ruby) incription_payment_file
#<SyBancolombia::Collection::Inscription::Payment::File:0x00007fb28df88238
 id: 6,
 status: "created",
 process_code: nil,
 last_download_date: nil,
 slug: "a680c56c-57bc-4d53-93d3-f07ea61d7fcd",
 token: "a680c56c-57bc-4d53-93d3-f07ea61d7fcd",
 public_token: "fd28cffb-a437-4fde-b09a-c04e92b817f6",
 discarded_at: nil,
 created_at: Tue, 01 Nov 2022 03:28:38.287658000 -05 -05:00,
 updated_at: Tue, 01 Nov 2022 03:28:38.324995000 -05 -05:00,
 modifier: "A",
 log_data: nil>
(ruby) incription_payment_file.file
#<ActiveStorage::Attached::One:0x00007fb27506fd68
 @name="file",
 @record=
  #<SyBancolombia::Collection::Inscription::Payment::File:0x00007fb28df88238
   id: 6,
   status: "created",
   process_code: nil,
   last_download_date: nil,
   slug: "a680c56c-57bc-4d53-93d3-f07ea61d7fcd",
   token: "a680c56c-57bc-4d53-93d3-f07ea61d7fcd",
   public_token: "fd28cffb-a437-4fde-b09a-c04e92b817f6",
   discarded_at: nil,
   created_at: Tue, 01 Nov 2022 03:28:38.287658000 -05 -05:00,
   updated_at: Tue, 01 Nov 2022 03:28:38.324995000 -05 -05:00,
   modifier: "A",
   log_data: nil>>
(rdbg)

(ruby) incription_payment_file.file.filename
#<ActiveStorage::Filename:0x00007fb2770ada08 @filename="INS_20221101032651.txt_A">
(rdbg)


#to download the generated file:
inscription_payment_file = SyBancolombia::Collection::Inscription::Payment::File.find(6).file
path_collection_inscriptions = ::SyPayCo::Engine.root.join('db', 'seeds', 'bancolombia_files', 'inscriptions_test.txt')
#FileUtils.mkdir_p path_collection_inscriptions.dirname
File.open(path_collection_inscriptions, 'wb') do |f|
  f.write(inscription_payment_file.download)
end
