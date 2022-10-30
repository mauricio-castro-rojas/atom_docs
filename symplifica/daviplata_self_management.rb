
Servicio para inscribir daviplata
SyPayCo::PaymentMethod::Daviplata::Payment::InscriptionService.new(contract_co: contract_co,
                                                                           number: daviplata_number, creator: current_employer).call


Servicio para borrar daviplata
::Support::PaymentMethod::Delete::ByAbstractPaymentMethodJob.perform_now(payment_method_id: contract_co.payment_method_id)
          contract_co.update!(payment_method: nil)

Servicio para generar payrolls
payroll = ::SyPayrollCo::Payrolls::GeneratePayroll.new(contract_id: contract_co.id,
                                                                        fortnight: :second_fortnight,
                                                                        month: Date.new(2022,9,1).month,
                                                                        year: Date.new(2022,9,1).year).generate

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
::SyPilaCo::Pila::Contributor.model_name.singular.to_sym

 GoodJob::Job
                                   .where(queue_name: :inscription_payment_method)
                                   .where("
            EXISTS (
                SELECT * FROM jsonb_array_elements(serialized_params #> '{arguments}') arguments
                WHERE (arguments -> 'contract_co' ->> '_aj_globalid') = :contract_co
              )
          ", contract_co: contract_co.to_gid.to_s)

GoodJob::Job
                                        .where(queue_name: :delete_payment_method)
                                        .where("
                                          EXISTS (
                                              SELECT * FROM jsonb_array_elements(serialized_params #> '{arguments}') arguments
                                              WHERE (arguments -> 'contract_co' ->> '_aj_globalid') = :contract_co
                                            )
                                        ", contract_co: contract_co.to_gid.to_s)
                          )
                      ", payment_method_id: contract_co.payment_method_id&.to_s)

                      GoodJob::Job
                                                               .where(queue_name: :change_payment_frequency)
                                                               .where("
                                   EXISTS (
                                       SELECT * FROM jsonb_array_elements(serialized_params #> '{arguments}') arguments
                                       WHERE (arguments -> 'contract' ->> '_aj_globalid') = :contract
                                     )
                                 ", contract: contract.to_gid.to_s)


(ruby) payroll.order_items&.first&.order&.status


GoodJob::Job
                                        .where(queue_name: :working_days)
                                        .where("
            EXISTS (
                SELECT * FROM jsonb_array_elements(serialized_params #> '{arguments}') arguments
                WHERE (arguments -> 'contract' ->> '_aj_globalid') = :contract
              )
          ", contract: contract.to_gid.to_s)


  SyPayrollCo::Payroll.find(21).update(payment_state: 0)
  SyPayrollCo::Payroll.find(21).order_items&.first&.order&.created!

#pruebas
I18n.t('date.month_names').values_at(3).last

ccf_kind_entity = create(::SyCore::SocialSecurityEntity::Kind.model_name.singular.to_sym,name: 'Caja de compensacion Familiar', code: 'CCF', country: @country)
afp_kind_entity = create(::SyCore::SocialSecurityEntity::Kind.model_name.singular.to_sym,name: 'Administradora de Fondos de Pensiones', code: 'AFP', country: @country)
ces_kind_entity = create(::SyCore::SocialSecurityEntity::Kind.model_name.singular.to_sym,name: 'Administradora de Fondos de Cesantias', code: 'CES', country: @country)
eps_kind_entity = create(::SyCore::SocialSecurityEntity::Kind.model_name.singular.to_sym,name: 'Entidad Promotora de Salud', code: 'EPS', country: @country)
arl_kind_entity = create(::SyCore::SocialSecurityEntity::Kind.model_name.singular.to_sym,name: 'Administradora de Riesgos Laborales', code: 'ARL', country: @country)

ccf = create(::SyCore::SocialSecurityEntity.model_name.singular.to_sym, kind: ccf_kind_entity, enabled: true, enabled_first_affiliation: true, score: 0, name: 'CCF CAFABA', code: 'CCF38')
afp = create(::SyCore::SocialSecurityEntity.model_name.singular.to_sym, kind: afp_kind_entity, enabled: true, enabled_first_affiliation: true, score: 0, name: 'AFP PROTECCION - ING', code: '230201')
ces = create(::SyCore::SocialSecurityEntity.model_name.singular.to_sym, kind: ces_kind_entity, enabled: true, enabled_first_affiliation: true, score: 0, name: 'FCES COLFONDOS', code: '10')
eps = create(::SyCore::SocialSecurityEntity.model_name.singular.to_sym, kind: eps_kind_entity, enabled: true, enabled_first_affiliation: true, score: 0, name: 'EPS ALIANSALUD', code: 'EPS001')
arl = create(::SyCore::SocialSecurityEntity.model_name.singular.to_sym, kind: arl_kind_entity, enabled: true, enabled_first_affiliation: true, score: 0, name: 'ARL SEGUROS BOLIVAR', code: '14-7')

create(::SyRegistry::Contract::EntityAfiliation.model_name.singular.to_sym, contract: @contract.base_contract, affiliate: @contract.employer, affiliate_kind: :employer, social_security_entity: ccf)
create(::SyRegistry::Contract::EntityAfiliation.model_name.singular.to_sym, contract: @contract.base_contract, affiliate: @contract.employer, affiliate_kind: :employer, social_security_entity: afp)
create(::SyRegistry::Contract::EntityAfiliation.model_name.singular.to_sym, contract: @contract.base_contract, affiliate: @contract.employer, affiliate_kind: :employer, social_security_entity: ces)
create(::SyRegistry::Contract::EntityAfiliation.model_name.singular.to_sym, contract: @contract.base_contract, affiliate: @contract.employer, affiliate_kind: :employer, social_security_entity: eps)
create(::SyRegistry::Contract::EntityAfiliation.model_name.singular.to_sym, contract: @contract.base_contract, affiliate: @contract.employer, affiliate_kind: :employer, social_security_entity: arl)

create(::SyRegistry::Contract::EntityAfiliation.model_name.singular.to_sym, contract: @contract.base_contract, affiliate: @contract.employee, affiliate_kind: :employee, social_security_entity: ccf)
create(::SyRegistry::Contract::EntityAfiliation.model_name.singular.to_sym, contract: @contract.base_contract, affiliate: @contract.employee, affiliate_kind: :employee, social_security_entity: afp)
create(::SyRegistry::Contract::EntityAfiliation.model_name.singular.to_sym, contract: @contract.base_contract, affiliate: @contract.employee, affiliate_kind: :employee, social_security_entity: ces)
create(::SyRegistry::Contract::EntityAfiliation.model_name.singular.to_sym, contract: @contract.base_contract, affiliate: @contract.employee, affiliate_kind: :employee, social_security_entity: eps)
create(::SyRegistry::Contract::EntityAfiliation.model_name.singular.to_sym, contract: @contract.base_contract, affiliate: @contract.employee, affiliate_kind: :employee, social_security_entity: arl)
@contract.reload


rails app:sy_pay_co:migrations:install
