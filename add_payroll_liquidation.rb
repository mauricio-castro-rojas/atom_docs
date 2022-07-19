# incluir en la liquidación las dos útlimos periodos disponibles. Si:
# contrato quincenal (la quincena actual y la anterior)
# contrato mensual (el mes actual y el anterior)

1. Si la nómina no se ha generado (si estamos al dia dos del mes) se debe usar el servicio de
generar payroll:

::SyPayrollCo::Payrolls::GeneratePayroll.new(contract_id: parroll.contract.id, fortnight: :first_fortnight,  month: "10", year: "2022")
::SyPayrollCo::Payrolls::GeneratePayroll.new(contract_id: parroll.contract.id, fortnight: :second_fortnight,  month: "10", year: "2022")

este servicio liquida la nómina entonces realmente hay que usar es el de simulación

::SyPayrollCo::Payrolls::CalculatePayroll.new()

current_employer = Employer.find_by_email('fernando.ricaurte@symplifica.com')

employees = SyLiquidationCo::Liquidation.where(contract: SyRegistryCo::Contract
  .where(base_contract: SyRegistry::Contract
    .where(employer: current_employer)), status: [:liquidated, :sent]).map{|l| l.contract&.base_contract&.employee}.uniq

SyLiquidationCo::Liquidation.where(contract: SyRegistryCo::Contract
  .where(base_contract: SyRegistry::Contract
    .where(employee: employees, employer: current_employer)), status: [:liquidated, :sent])


= form.submit id: "upload_file", class: "hidden"


# Liquidación para hacer pruebas con el builder (generar documentos)
liquidation = SyLiquidationCo::Liquidation.find(8637)

::SyLiquidationCo::Liquidation::Pdf::Builder.new(liquidation_co: liquidation).call

::SyLiquidationCo::Liquidation::LiquidationMailer.new(liquidation_co: liquidation).send_mail

#Arreglar vista del pdf generado (secciones metidas dentro de un solo div)

=> summary.html.erb div padre de la linea 25 : partir cada section en un div, no que haya un div padre



Tarea por completar:

en app/services/sy_liquidation_co/liquidation/generate_liquidation.rb
hay una función que se llama: ::SyLiquidationCo::Liquidation::ClosePayrolls.new(contract_co: @contract_co)
que es la que se encarga de cerrar la nómina o recalcularla (en caso que esté creada), y desanclar
la nómina de la factura si esta pertenece a una (update_order_by_payroll).

Este método ya se encarga de hacer esas dos cosas para el periodo actual pero no para el periodo anterior.
Es decir que para el caso donde no hay periodo generado el servicio ya se encargaria de eso, pero
para cuando ya hay un payroll generado toca:


1. consultar el periodo (periodo anterior) hacerles un find
2. cambiarle los estados (pasarlo a created)
3. Llamar el servicio ::SyPayrollCo::Payrolls::Generate


Dónde o como hacerlo?

modificar el método de close payrrolls para que modifique el payroll del periodo anterior , que viene como parametro
en el initializer de Generate liquidation (viene en un arreglo de payrolls [id nil del payroll actual osea esos no])
buscar los que tienen el id


entonces en close payrolls:

find al payroll
  payroll.end_date > 16
    mandaria second_fortnight si no first fortnight
