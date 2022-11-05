Generation file process

1. Search for SyPay::Transaction in created state where davivienda is
   set as the gateway. This group of transactions are sent to a mapping
   data method and return as an array with info to process.
   Each element on the array is a hash of data related to each transaction.

2. The Generator service is called with the array of hashes
(transactions_generator_file of class ::SyDavivienda::Collection::Transaction::Payment::File::Generator)

3. An instance of transaction payment file model is created based on the generated file (transactions_generator_file)
(transaction_payment_file = ::SyDavivienda::Collection::Transaction::Payment::File.new)
    transaction_payment_file.file.attach(
      io: transactions_generator_file.file,
      filename: Time.now.strftime("#{::SyDavivienda::Collection::Transaction::Payment::ACRONYM}%Y%m%d%H%M%S.txt")
    )

4. Search for ::SyDavivienda::Transaction::Payment.where(_transaction: sy_pay_transactions) -> array
   Search for ::SyDavivienda::Collection::Transaction::Payment.where(_transaction: transactions of previous step) -> array

   // Dónde se crean estas relaciones?

   sy_davivienda_collection_transaction_payments.each do |sy_davivienda_collection_transaction_payment|
        sy_davivienda_collection_transaction_payment.update! file: transaction_payment_file
   end

   sy_pay_transactions.each(&:in_process!)

Read file process

1. Desde este controlador en sy app admin: Payments::PaymentModule::CollectionUploadFilesController
  file_io = params[:file]
  collection_file_response = ::SyDavivienda::Collection::Transaction::Payment::Response.create!(
    file: file_io
  )

  ::SyPayCo::Collection::Transaction::Payment::Response::File::Davivienda::ReadJob.perform_later(collection_file_response)

2. El job recibe ese objeto como:
  def perform(transaction_response)
    Donde transaction response es un objeto de clase
    ::SyDavivienda::Collection::Transaction::Payment::Response


    Luego se pasa a en proceso esa transaccion
    transaction_response.in_process!

3. Llama al servicio del reader:
 reader_transaction_response_file = ::SyDavivienda::Collection::Transaction::Payment::Response::File::Reader.new(file: transaction_response.file)

4. Por cada fila del reader busca sy pay transactions y sy davivienda transaction payments
reader_transaction_response_file.rows.each do |row|
  sy_pay_transaction = ::SyPay::Transaction.find(row.processed_data[:description])
  sy_davivienda_collection_transaction = ::SyDavivienda::Transaction::Payment.find_by!(_transaction: sy_pay_transaction).delegated_transaction

5. Finalmente se asocia  un ::SyDavivienda::Transaction::Payment
  al link response de la instancia de ::SyDavivienda::Collection::Transaction::Payment::Response

transaction_response.link_responses.create!(
          transaction_payment: sy_davivienda_collection_transaction,
          status_code_bank: row.processed_data[:status_code_bank],
          status_bank: row.processed_data[:status_bank],
          status_message_bank: row.processed_data[:status_message_bank]
        )

6. Se procesa el estado:
        transaction_response.processed!



--------------------------------------------------

Desde el SyPay::CollectionService

se llama a este metodo:

def davivienda_transaction_create(transaction)
      davivienda_collection_payment = ::SyDavivienda::Collection::Transaction::Payment.create!()
      data_davivienda_collection_payment = {
        delegated_transaction: davivienda_collection_payment,
        _transaction: transaction
      }
      ::SyDavivienda::Transaction::Payment.create!(data_davivienda_collection_payment)
end
