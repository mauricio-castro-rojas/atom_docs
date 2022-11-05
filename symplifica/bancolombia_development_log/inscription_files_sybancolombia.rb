------------------------------------------------------------------------------------------------------------
Inscriptions

How to associate a SyPay::PaymentMethod::Inscription to ::SyBancolombia::Collection::Inscription::Payment
and to  ::SyBancolombia::Inscription::Payment::

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


#script to execute response file for inscription  reader job

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

----------------------------------------------------------------------------------------------------------------------------------------
