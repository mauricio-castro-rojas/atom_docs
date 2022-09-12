
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

        [#<GoodJob::Job:0x00007f7c8651fae0
  id: "68189474-578e-4bef-a7ea-519932edd830",
  queue_name: "inscription_payment_method",
  priority: 10,
  serialized_params:
   {"job_id"=>"68afc94b-093d-4ece-a0f3-e22cf797b938",
    "locale"=>"es",
    "priority"=>10,
    "timezone"=>"America/Bogota",
    "arguments"=>
     [{"number"=>"3119998877",
       "creator"=>{"_aj_globalid"=>"gid://sy-app/Employer/1"},
       "contract_co"=>{"_aj_globalid"=>"gid://sy-app/SyRegistryCo::Contract/1"},
       "_aj_ruby2_keywords"=>["contract_co", "number", "creator"]}],
    "job_class"=>"SyPayCo::SelfManagement::InscriptionPaymentMethodJob",
    "executions"=>0,
    "queue_name"=>"inscription_payment_method",
    "enqueued_at"=>"2022-09-07T18:54:42Z",
    "provider_job_id"=>nil,
    "exception_executions"=>{}},
  scheduled_at: Fri, 16 Sep 2022 00:00:00.000000000 -05 -05:00,
  performed_at: nil,
  finished_at: nil,
  error: nil,
  created_at: Wed, 07 Sep 2022 13:54:42.612532000 -05 -05:00,
  updated_at: Wed, 07 Sep 2022 13:54:42.612532000 -05 -05:00,
  active_job_id: "68afc94b-093d-4ece-a0f3-e22cf797b938",
  concurrency_key: nil,
  cron_key: nil,
  retried_good_job_id: nil,
  cron_at: nil>]


        enqued_jobs1 = GoodJob::Job
          .where(queue_name: :inscription_payment_method)
          .where("
            EXISTS (
                SELECT * FROM jsonb_array_elements(serialized_params #> '{arguments}') arguments
                WHERE (arguments -> 'contract_co' ->> '_aj_globalid') = :contract_co
              )
          ", contract_co: @contract_co.to_gid.to_s)




          enqued_jobs2 = GoodJob::Job
            .where(queue_name: :delete_payment_method)
            .where("
              EXISTS (
                  SELECT * FROM jsonb_array_elements(serialized_params #> '{arguments}') arguments
                  WHERE (arguments -> 'payment_method_id') = :payment_method_id
                )
            ", payment_method_id: @contract_co.payment_method_id.to_s)

            GoodJob::Job.where(queue_name: :delete_by_abstract_payment_method).where("serialized_params['arguments'] @> ?", '[{"payment_method_id":22}]')


 .update_payment_method_employee_contract_path(params[:employee_contract_id])

 enqued_jobs2 = GoodJob::Job
   .where(queue_name: :change_payment_frequency)
   .where("
     EXISTS (
         SELECT * FROM jsonb_array_elements(serialized_params #> '{arguments}') arguments
         WHERE (arguments -> 'contract' ->> '_aj_globalid') = :contract
       )
   ", contract: @contract.to_gid.to_s)

   [#<GoodJob::Job:0x00007faf77e67278
  id: "db6f1563-0e77-4ae5-80fe-f1c3de4f92ed",
  queue_name: "change_payment_frequency",
  priority: 10,
  serialized_params:
   {"job_id"=>"82be9c4c-9daf-4ea5-ac48-fbea19dd6a38",
    "locale"=>"es",
    "priority"=>10,
    "timezone"=>"America/Bogota",
    "arguments"=>
     [{"contract"=>{"_aj_globalid"=>"gid://sy-app/SyRegistry::Contract/2"},
       "_aj_ruby2_keywords"=>["contract", "frequency_to_change"],
       "frequency_to_change"=>"mensual"}],
    "job_class"=>"SyPayCo::SelfManagement::ChangePaymentFrequencyJob",
    "executions"=>0,
    "queue_name"=>"change_payment_frequency",
    "enqueued_at"=>"2022-09-07T13:30:56Z",
    "provider_job_id"=>nil,
    "exception_executions"=>{}}


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


days="{:monday=>false, :tuesday=>true, :wednesday=>true, :thursday=>true, :friday=>false, :saturday=>true, :sunday=>false}"
JSON.parse days.gsub(':', '').gsub('=>', ': ')


days="{\"monday\":false,\"tuesday\":true,\"wednesday\":true,\"thursday\":true,\"friday\":false,\"saturday\":true,\"sunday\":false}"
JSON.parse days


data = {"monday"=>false, "tuesday"=>true, "wednesday"=>true, "thursday"=>true, "friday"=>false, "saturday"=>true, "sunday"=>false}


days_names = data.map {|k,v| k if v.eql? true}.compact

::SyCore::Day.where(name: days_names).each do |day|
        contract.day_linkeables.create(day: day, creator: @current_admin)
      end
days_names = data.map {|k,v| k if v.eql? true}.compact



count = 0
data.each {|k,v| count+=1 if v}

Deseas cambiar los dias de trabajo? Si
Selecciona los dias a trabajar Lunes, Martes
days_selection
[1, 3]

Deseas cambiar los dias de trabajo? Si
Selecciona los dias a trabajar Domingo, Miércoles, Jueves, Viernes, Sábado

(ruby) days_selection
[2, 4, 5, 6, 7]
(rdbg)


[#<SyCore::Day:0x00007fab18e60cd8
  id: 1,
  name: "monday",
  created_at: Mon, 01 Aug 2022 08:36:23.706831000 -05 -05:00,
  updated_at: Mon, 01 Aug 2022 08:36:23.706831000 -05 -05:00,
  discarded_at: nil,
  log_data: nil>,
 #<SyCore::Day:0x00007fab18e90e10
  id: 2,
  name: "sunday",
  created_at: Mon, 01 Aug 2022 08:36:23.717255000 -05 -05:00,
  updated_at: Mon, 01 Aug 2022 08:36:23.717255000 -05 -05:00,
  discarded_at: nil,
  log_data: nil>,
 #<SyCore::Day:0x00007fab18e90d48
  id: 3,
  name: "tuesday",
  created_at: Mon, 01 Aug 2022 08:36:23.723721000 -05 -05:00,
  updated_at: Mon, 01 Aug 2022 08:36:23.723721000 -05 -05:00,
  discarded_at: nil,
  log_data: nil>,
 #<SyCore::Day:0x00007fab18e90c80
  id: 4,
  name: "wednesday",
  created_at: Mon, 01 Aug 2022 08:36:23.737950000 -05 -05:00,
  updated_at: Mon, 01 Aug 2022 08:36:23.737950000 -05 -05:00,
  discarded_at: nil,
  log_data: nil>,
 #<SyCore::Day:0x00007fab18e90bb8
  id: 5,
  name: "thursday",
  created_at: Mon, 01 Aug 2022 08:36:23.742661000 -05 -05:00,
  updated_at: Mon, 01 Aug 2022 08:36:23.742661000 -05 -05:00,
  discarded_at: nil,
  log_data: nil>,
 #<SyCore::Day:0x00007fab18e90af0
  id: 6,
  name: "friday",
  created_at: Mon, 01 Aug 2022 08:36:23.747177000 -05 -05:00,
  updated_at: Mon, 01 Aug 2022 08:36:23.747177000 -05 -05:00,
  discarded_at: nil,
  log_data: nil>,
 #<SyCore::Day:0x00007fab18e90a28
  id: 7,
  name: "saturday",
  created_at: Mon, 01 Aug 2022 08:36:23.751113000 -05 -05:00,
  updated_at: Mon, 01 Aug 2022 08:36:23.751113000 -05 -05:00,
  discarded_at: nil,
  log_data: nil>]

Aplicar el cambio ahora:

  if Time.zone.now.day < 6
  si la nomina del trabajador está pendientes o sin ordenes asociadas
  si la pila del mes no se ha pagado
