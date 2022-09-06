
Servicio para inscribir daviplata
SyPayCo::PaymentMethod::Daviplata::Payment::InscriptionService.new(contract_co: contract_co,
                                                                           number: daviplata_number, creator: current_employer).call


Servicio para borrar daviplata
::Support::PaymentMethod::Delete::ByAbstractPaymentMethodJob.perform_now(payment_method_id: contract_co.payment_method_id)
          contract_co.update!(payment_method: nil)

contract = ::SyRegistry::Contract.find(2)
contract_co = ::SyRegistryCo::Contract.where(base_contract: contract).first
current_employer = Employer.first
daviplata_number = "3119887766"

Date.today.at_beginning_of_month.next_month

not_pending_payrolls = contract_co.payrolls.where(start_date: [Time.now.beginning_of_month..Time.now.end_of_month])
                                     .where.not(payment_state: :pending)
      if not_pending_payrolls.any?
        print_error do
          'No es posible realizar el cambio ya que hay nominas en proceso de pago en el mes actual'
        end
      else


        enqued_jobs2 = GoodJob::Job
          .where(queue_name: :change_payroll_payment_method)
          .where("
            EXISTS (
                SELECT * FROM jsonb_array_elements(serialized_params #> '{arguments}') arguments
                WHERE (arguments -> 'contract_co' ->> '_aj_globalid') = :contract_co
              )
          ", contract_co: contract_co.to_gid.to_s)

          enqued_jobs2 = GoodJob::Job
            .where(queue_name: :delete_by_abstract_payment_method)
            .where("
              EXISTS (
                  SELECT * FROM jsonb_array_elements(serialized_params #> '{arguments}') arguments
                  WHERE (arguments -> 'payment_method_id') = :payment_method_id
                )
            ", payment_method_id: @contract_co.payment_method_id.to_s)

            GoodJob::Job.where(queue_name: :delete_by_abstract_payment_method).where("serialized_params['arguments'] @> ?", '[{"payment_method_id":22}]')


 .update_payment_method_employee_contract_path(params[:employee_contract_id])


 = form_with url: save_liquidation_liquidations_path, format: :turbo_stream, :id => 'modal-liquidation-form' do |form|
        = form.hidden_field :liquidation_id, value: @liquidation.id
        = form.hidden_field :liquidation_date, value: session[:date_liquidation_selected].to_date
        div[class="flex justify-center text-justify items-center pl-2 pr-4  lg:pl-16 pt-5 w-full md:w-7/12 lg:w-11/12  "]
            div[class="flex inline "]
                input[id="check_automatic_debit" value="on" name="check_automatic_debit" type="checkbox" checked class="h-4 w-4 text-symplifica-light focus:ring-symplifica-light border-gray-300 rounded-full mt-1"]
                label[for="check_automatic_debit" class="ml-2 block text-gray-900 text-justify text-xs lg:text-base font-light"]
                    |Estoy de acuerdo en que debiten de mi cuenta el valor de la planilla de retiro
                    b.ml-1 y deseo
                    span[class="font-medium ml-1"] finalizar el contrato
                    b.ml-1 con este empleado


        div[class="flex justify-center mt-8 pb-5 text-center"]
            = button_tag "Liquidar empleado", class: "cursor-pointer items-center py-2 mx-3 border border-transparent text-sm md:text-base font-medium rounded-full shadows focus:outline-none focus:ring-2 focus:ring-offset-2 bg-symplifica-red text-white hover:bg-symplifica-hoverred w-full md:w-10/12 lg:w-8/12 px-10", id: "liquidate_employee"
