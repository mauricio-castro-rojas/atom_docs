


Date.today.at_beginning_of_month.next_month



class Siigo::UpdateEmailJob < ApplicationJob
  queue_as :siigo_update

Preguntas fer

delayed job para cancelar un job?

consultas en json o en hashes => diego

good job para sypay co? solo esta la gema en el gemfile , no hay migraciones
validacion del daviplata ingresado, el servicio de inscripcion no realiza ninguna validacion si son caracteres validos o numero de caracteres
como hacer pruebas con el wait


not_pending_payrolls = contract_co.payrolls.where(start_date: [Time.now.beginning_of_month..Time.now.end_of_month])
                                     .where.not(payment_state: :pending)
      if not_pending_payrolls.any?
        print_error do
          'No es posible realizar el cambio ya que hay nominas en proceso de pago en el mes actual'
        end
      else


        enqued_jobs = GoodJob::Job
          .where(queue_name: 'change_payroll_payment_method')
          .where("
            EXISTS (
                SELECT * FROM jsonb_array_elements(serialized_params #> '{arguments}') arguments
                WHERE (arguments -> 'contract_co' ->> '_aj_globalid') = :contract_co
              )
          ", contract_co: SyRegistryCo::Contract.find(19522).to_gid.to_s)
