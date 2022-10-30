
# TESTING INVOICE SERVICE FOR Liquidation
::SyPayCo::Liquidation::Invoice::InvoiceService.new(liquidation: liquidation).call
=> #<SyRegistry::Contract:0x000000016efb8280
 id: 3030,
 employer_type: "Employer",
 employer_id: 1372,
 employee_type: "Employee",
 employee_id: 1866,
 kind_id: 2,
 start_date: Fri, 23 Aug 2019,
 planned_end_date: nil,
 end_date: Fri, 13 May 2022,
 test_period_end_date: Wed, 23 Oct 2019,
 working_day_start_time: Sat, 01 Jan 2000 08:00:00.000000000 -05 -05:00,
 working_day_end_time: Sat, 01 Jan 2000 14:00:00.000000000 -05 -05:00,
 payment_frequency: "biweekly",
 automatic_renewal: false,
 base_salary_cents: 100000000,
 base_salary_currency: "COP",
 is_old_contract: true,
 platforms: {},
 monthly_worked_days: 30,
 created_at: Fri, 23 Aug 2019 00:00:00.000000000 -05 -05:00,
 updated_at: Mon, 16 May 2022 09:23:40.078224000 -05 -05:00,
 status: "ended",
 discarded_at: nil,
 activation_date: Fri, 23 Aug 2019,
 creator_type: nil,
 creator_id: nil,
 log_data: nil>
[84] pry(main)> liquidation.contract.base_contract.update(status: :active, end_date: nil)


liquidation = SyLiquidationCo::Liquidation.where('request_date >= ?', Date.new(2022,5,10)).first
=> #<SyLiquidationCo::Liquidation:0x000000016eea2c60
 id: 416,
 contract_type: "SyRegistryCo::Contract",
 contract_id: 3028,
 kind: "resignation",
 reason: "",
 status: "liquidated",
 days_absenteeism: 0,
 days_worked: 133,
 days_caused: 981,
 amount_cents: 220626381,
 amount_currency: "COP",
[81] pry(main)> liquidation.contract
=> #<SyRegistryCo::Contract:0x000000016ef43930
 id: 3028,
 base_contract_type: "SyRegistry::Contract",
 base_contract_id: 3030,
 working_day_type: "full_time",
 transportation_assistance: true,
 health_subscription_kind: "contributor",
 retirement_subscription_kind: "not_pensioned",
 employee_working_distance: "more_than_1k",
 arl_rate: "one",
 created_at: Sat, 11 Sep 2021 16:00:47.364703000 -05 -05:00,
 updated_at: Sat, 11 Sep 2021 16:00:47.364703000 -05 -05:00,
 registry_path: nil,
 payment_method_id: nil,
 slug: "0de6b876-3b42-4c6e-a894-bb7e432370a2",
 token: "0de6b876-3b42-4c6e-a894-bb7e432370a2",
 public_token: "fb00a2de-f9c7-49e3-a2cc-33f5986850b5",
 discarded_at: nil,
 log_data: nil>
[82] pry(main)> liquidation.update(status: 0)
warning: 299 Elasticsearch-7.17.4-79878662c54c886ae89206c685d9f1051a9d6411 "Elasticsearch built-in security features are not enabled. Without authentication, your cluster could be accessible to anyone. See https://www.elastic.co/guide/en/elasticsearch/reference/7.17/security-minimal-setup.html to enable security."
=> true
[83] pry(main)> liquidation.contract.base_contract
=> #<SyRegistry::Contract:0x000000016efb8280
 id: 3030,
 employer_type: "Employer",
 employer_id: 1372,
 employee_type: "Employee",
 employee_id: 1866,
 kind_id: 2,
 start_date: Fri, 23 Aug 2019,
 planned_end_date: nil,
 end_date: Fri, 13 May 2022,
 test_period_end_date: Wed, 23 Oct 2019,
 working_day_start_time: Sat, 01 Jan 2000 08:00:00.000000000 -05 -05:00,
 working_day_end_time: Sat, 01 Jan 2000 14:00:00.000000000 -05 -05:00,
 payment_frequency: "biweekly",
 automatic_renewal: false,
 base_salary_cents: 100000000,
 base_salary_currency: "COP",
 is_old_contract: true,
 platforms: {},
 monthly_worked_days: 30,
 created_at: Fri, 23 Aug 2019 00:00:00.000000000 -05 -05:00,
 updated_at: Mon, 16 May 2022 09:23:40.078224000 -05 -05:00,
 status: "ended",
 discarded_at: nil,
 activation_date: Fri, 23 Aug 2019,
 creator_type: nil,
 creator_id: nil,
 log_data: nil>
[84] pry(main)> liquidation.contract.base_contract.update(status: :active, end_date: nil)

(ruby) ::SyPayCo::Invoice::Services::Items::TransactionalItem.new(order: self.order).start
#<SyBase::ErrorNotify:0x0000000151ee5140
 @exception=
  #<ActiveRecord::AssociationTypeMismatch: SyPay::Order(#229660) expected, got #<SyPay::Order id: 799029, owner_type: "Employer", owner_id: 1372, code: "202363", status: "created", due_date: "2022-06-29", slug: "c0f5c067-794e-49d9-9ee6-42cb40b3d6d8", token: "c0f5c067-794e-49d9-9ee6-42cb40b3d6d8", public_token: "ee43c701-56eb-4cc7-af5b-6112aa2f0f3c", created_at: "2022-06-17 00:33:22.996643000 -0500", updated_at: "2022-06-17 00:33:22.996643000 -0500", amount_cents: 0, amount_currency: "COP", tax_amount_cents: 0, tax_amount_currency: "COP", balance_cents: 0, balance_currency: "COP", automatic_debit_log: "{}", discarded_at: nil, log_data: nil> which is an instance of SyPay::Order(#193920)>,
 @more_data={}>


 hola fer,
12:46
que pena molestar
12:46
es que me sigue saliendo el mismo error al intentar crear el costo transaccional:
12:46
#<SyBase::ErrorNotify:0x00000001583e3588
 @exception=
  #<ActiveRecord::AssociationTypeMismatch: SyPay::Order(#243540) expected, got #<SyPay::Order id: 799031, owner_type: "Employer", owner_id: 1372, code: "202363", status: "created", due_date: "2022-06-29", slug: "d29681f1-f978-4f3c-9713-36565699108b", token: "d29681f1-f978-4f3c-9713-36565699108b", public_token: "4a17605a-20e0-41e6-bf20-9829e0bca910", created_at: "2022-06-17 12:43:50.323658000 -050
12:47
ya le quité los debugger a todo e igual no crea el item de costo
12:47
el de liquidacion si lo está generando


Fernando Ricaurte
  12:51 PM
para el server
12:51
limpia el cache
12:51
dos veces
12:52
y lanza otra vez

Mauricio Castro
  12:53 PM
ok , esto se puede usar en la consola?
12:54
Rails.cache.clear

Fernando Ricaurte
  12:54 PM
rails dev:cache
12:54
rails dev:cache



Pruebas realizadas sobre el empleado de fer , desde el front
Empleados activos de fer pruebas

employer = Employer.find_by_document(number: '12345678910').last

#contracts co :

"Empleado: Sandra Rodriguez 23123, Id: 19553"
"Empleado: employee1946-36@symplifica.com  employee1946-36@symplifica.com, Id: 22238"
"Empleado: employee295-36@symplifica.com  employee295-36@symplifica.com, Id: 22243"
"Empleado: employee3005-36@symplifica.com employee3005-36@symplifica.com, Id: 22250"
"Empleado: rwerwerwer werwer werwer werwer, Id: 25287"
"Empleado: asdasda asdasd aasda adsasd, Id: 25854"
"Empleado: Employee476 36@Symplifica.Com Employee476 36@Symplifica.Com, Id: 31111"
"Empleado: employee2304-36@symplifica.com employee2304-36@symplifica.com, Id: 31181"
"Empleado: Nestor Fernando Ricaurte Aguirre, Id: 31182"
"Empleado: Maria Employee2035 36@Symplifica.Com, Id: 31725"
"Empleado: employee4254-36@symplifica.com employee4254-36@symplifica.com, Id: 33449"
"Empleado: Employee3381 36@Symplifica.Com Employee3381 36@Symplifica.Com, Id: 34413"
"Empleado: Employee2347 36@Symplifica.Com Employee2347 36@Symplifica.Com, Id: 34582"
"Empleado: Employee3060 36@Symplifica.Com Employee3060 36@Symplifica.Com, Id: 34591"
"Empleado: Employee1424 36@Symplifica.Com Employee1424 36@Symplifica.Com, Id: 34699"
"Empleado: Employee1547 36@Symplifica.Com Employee1547 36@Symplifica.Com, Id: 34751"
"Empleado: Employee3179 36@Symplifica.Com Employee3179 36@Symplifica.Com, Id: 34762"
"Empleado: Employee1035 36@Symplifica.Com Employee1035 36@Symplifica.Com, Id: 34764"
"Empleado: Employee2023 36@Symplifica.Com Employee2023 36@Symplifica.Com, Id: 35128"
"Empleado: Juana Juana Perez Perez, Id: 35130"
"Empleado: Employee4024 36@Symplifica.Com Employee4024 36@Symplifica.Com, Id: 35178"
"Empleado: Employee1657 36@Symplifica.Com Employee1657 36@Symplifica.Com, Id: 35226"
"Empleado: Employee3927 36@Symplifica.Com Employee3927 36@Symplifica.Com, Id: 35711"
"Empleado: Employee2161 36@Symplifica.Com Employee2161 36@Symplifica.Com, Id: 35712"
"Empleado: Employee1148 36@Symplifica.Com Employee1148 36@Symplifica.Com, Id: 35749"
"Empleado: Employee2737 36@Symplifica.Com Employee2737 36@Symplifica.Com, Id: 35756"
"Empleado: Employee2955 36@Symplifica.Com Employee2955 36@Symplifica.Com, Id: 35757"
"Empleado: Employee3442 36@Symplifica.Com Employee3442 36@Symplifica.Com, Id: 35926"
"Empleado: Nestor Fernando Ricaurte Aguirre, Id: 36355"
"Empleado: Employee2719 36@Symplifica.Com Employee2719 36@Symplifica.Com, Id: 36356"
"Empleado: Employee2984 36@Symplifica.Com Employee2984 36@Symplifica.Com, Id: 36944"



contract_co = SyRegistryCo::Contract.find(33449)
contract = contract_co.base_contract
contract_co.employee.full_name
=> "Employee1035 36@Symplifica.Com Employee1035 36@Symplifica.Com"
SyLiquidationCo::Liquidation.where(contract: contract)





::SyAppLiquidation::GenerateLiquidationJob.perform_now(contract_co: contract_co,
                                                                 liquidation_date: Date.new(2022,6,25),
                                                                 liquidation_reason: :mutual_agreement,
                                                                 is_pre_liquidation: false,
                                                                 signed: false,
                                                                 liquidation_with_symplifica: true,
                                                                 creator: (Admin.find(48)))



Prueba generada desde el front

contract.employer.orders.last.order_items
=> [#<SyPay::Order::Item:0x0000000160523f08
  id: 931143,
  order_id: 799037,
  item_type: "SyPay::Products::TransactionCost",
  item_id: 1,
  slug: "863d5ef3-93a3-4621-8ce6-5f9b01aa428b",
  token: "863d5ef3-93a3-4621-8ce6-5f9b01aa428b",
  public_token: "0ea9cfab-d0c7-46ea-8a02-093d3ba473e7",
  created_at: Tue, 21 Jun 2022 14:05:41.490750000 -05 -05:00,
  updated_at: Tue, 21 Jun 2022 14:05:41.490750000 -05 -05:00,
  amount_cents: 590000,
  amount_currency: "COP",
  discarded_at: nil,
  conciliation_status: "pending",
  conciliation_payment_status: "payment_pending",
  log_data: nil>,
 #<SyPay::Order::Item:0x0000000160523b20
  id: 931144,
  order_id: 799037,
  item_type: "SyLiquidationCo::Liquidation",
  item_id: 8632,
  slug: "6cb13ca6-99a6-4357-86b8-789b5bec272f",
  token: "6cb13ca6-99a6-4357-86b8-789b5bec272f",
  public_token: "5164851c-0c2e-404e-810a-bf432b895b51",
  created_at: Tue, 21 Jun 2022 14:05:42.336453000 -05 -05:00,
  updated_at: Tue, 21 Jun 2022 14:05:42.336453000 -05 -05:00,
  amount_cents: 214516696,
  amount_currency: "COP",
  discarded_at: nil,
  conciliation_status: "pending",
  conciliation_payment_status: "payment_pending",
  log_data: nil>,
 #<SyPay::Order::Item:0x0000000160523828
  id: 931148,
  order_id: 799037,
  item_type: "SyLiquidationCo::Liquidation",
  item_id: 8635,
  slug: "59ecffe5-e348-4ca2-b2be-43cc91a06626",
  token: "59ecffe5-e348-4ca2-b2be-43cc91a06626",
  public_token: "57468a62-1eac-4624-8686-c942149c19ef",
  created_at: Tue, 21 Jun 2022 14:40:28.212336000 -05 -05:00,
  updated_at: Tue, 21 Jun 2022 14:40:28.212336000 -05 -05:00,
  amount_cents: 140197883,
  amount_currency: "COP",
  discarded_at: nil,
  conciliation_status: "pending",
  conciliation_payment_status: "payment_pending",
  log_data: nil>]
(END)


[268] pry(main)> contract
=> #<SyRegistry::Contract:0x000000014dc4d6e8
 id: 5330,
 employer_type: "Employer",
 employer_id: 2308,
 employee_type: "Employee",
 employee_id: 3417,
 kind_id: 2,
 start_date: Fri, 17 Jul 2020,
 planned_end_date: nil,
 end_date: Wed, 22 Jun 2022,
 test_period_end_date: Thu, 17 Sep 2020,
 working_day_start_time: Sat, 01 Jan 2000 08:00:00.000000000 -05 -05:00,
 working_day_end_time: Sat, 01 Jan 2000 14:00:00.000000000 -05 -05:00,
 payment_frequency: "biweekly",
 automatic_renewal: false,
 base_salary_cents: 110000000,
 base_salary_currency: "COP",
 is_old_contract: nil,
 platforms: {},
 monthly_worked_days: 30,
 created_at: Fri, 17 Jul 2020 00:00:00.000000000 -05 -05:00,
 updated_at: Tue, 21 Jun 2022 14:02:49.592337000 -05 -05:00,
 status: "active",
 discarded_at: nil,
 activation_date: Fri, 17 Jul 2020,
 creator_type: nil,
 creator_id: nil,
 log_data: nil>
[269] pry(main)>


Forma de probar el observer:
Nos vamos directamente al item (no al order_item de la orden) , actualizamos el payment state y luego sobre el mismo objeto
lanzamos el metodo .set_payment_state

Para que funcione la liquidacion debe estar dentro de la factura, y debe tener transacciones de recaudo sobre ese item
Forma de hacerlo:
Generar transacciones manualmente y asociarlas a la orden
Coger una orden pagada y asociar el item de liquidacion a esa orden
Registrar una cuenta bancaria que esté activa, hacer el pago de esa factura, pasar el estado de pago de esas transacciones
y automaticamente ya debe estar funcionando


El metodo set_payment_state se basa en el estado de las transacciones para actualizar el item, para hacer pruebas
hay que hacerlas con transacciones rechazadas y pagadas.

contract.employer.orders.paid.where('due_date > ?', Date.new(2022,2,1))
=> [#<SyPay::Order:0x00000001676dc3c0
  id: 503881,
  owner_type: "Employer",
  owner_id: 2308,
  code: "185239",
  status: "paid",
  due_date: Mon, 28 Feb 2022,
  slug: "a121bc18-f641-4cc6-9901-a0659a1f11ce",
  token: "a121bc18-f641-4cc6-9901-a0659a1f11ce",
  public_token: "0d1bb9b6-fc9c-4cf7-adc1-d03b35adaa0d",
  created_at: Sun, 20 Feb 2022 02:25:16.652761000 -05 -05:00,
  updated_at: Thu, 17 Mar 2022 09:47:17.267826000 -05 -05:00,
  amount_cents: 91240000,
  amount_currency: "COP",
  tax_amount_cents: 0,
  tax_amount_currency: "COP",
  balance_cents: 0,
  balance_currency: "COP",
  automatic_debit_log:
   [{"msg"=>"Transaction created", "flag"=>true, "created_at"=>"2022-02-25T13:55:39.287+00:00", "payment_method"=>45706},
    {"msg"=>"Transaction created", "flag"=>true, "created_at"=>"2022-03-02T15:18:44.892+00:00", "payment_method"=>45706},
    {"msg"=>"Transaction created", "flag"=>true, "created_at"=>"2022-03-07T13:28:36.216+00:00", "payment_method"=>6805}],
  discarded_at: nil,
  log_data: nil>]

  SyLiquidationCo::Liquidation.where(contract: contract_co).first
=> #<SyLiquidationCo::Liquidation:0x000000014a361f28
 id: 8632,
 contract_type: "SyRegistryCo::Contract",
 contract_id: 5329,
 kind: "contract_termination_with_just_cause",
 reason: "",
 status: "in_created",
 days_absenteeism: 0,
 days_worked: 172,
 days_caused: 696,
 amount_cents: 214516696,
 amount_currency: "COP",
 slug: "d4d0a7ef-22ac-4bcb-9813-d9694c868c3e",
 token: "d4d0a7ef-22ac-4bcb-9813-d9694c868c3e",
 public_token: "afbea4ff-63eb-434d-bfa0-4186e7e2a74a",
 created_at: Tue, 21 Jun 2022 08:48:21.373032000 -05 -05:00,
 updated_at: Wed, 22 Jun 2022 17:55:57.554828000 -05 -05:00,
 send_date: nil,
 creator_type: "Admin",
 creator_id: 48,
 discarded_at: nil,
 request_date: Tue, 21 Jun 2022,
 liquidated_date: nil,
 contract_signed: false,
 payment_state: "pending",
 log_data: nil>

 contract.employer.orders.last
=> #<SyPay::Order:0x000000014a453c60
 id: 799037,
 owner_type: "Employer",
 owner_id: 2308,
 code: "202367",
 status: "created",
 due_date: Wed, 29 Jun 2022,
 slug: "383c2aa8-f72d-47bc-b06b-f188f64aad0d",
 token: "383c2aa8-f72d-47bc-b06b-f188f64aad0d",
 public_token: "2290d610-c134-4224-b3f1-6bca59734819",
 created_at: Tue, 21 Jun 2022 14:05:39.976373000 -05 -05:00,
 updated_at: Tue, 21 Jun 2022 14:40:29.049001000 -05 -05:00,
 amount_cents: 355304579,
 amount_currency: "COP",
 tax_amount_cents: 0,
 tax_amount_currency: "COP",
 balance_cents: 0,
 balance_currency: "COP",
 automatic_debit_log: "{}",
 discarded_at: nil,
 log_data: nil>

 contract.employer.orders.last.order_items
=> [#<SyPay::Order::Item:0x000000014d09da50
  id: 931143,
  order_id: 799037,
  item_type: "SyPay::Products::TransactionCost",
  item_id: 1,
  slug: "863d5ef3-93a3-4621-8ce6-5f9b01aa428b",
  token: "863d5ef3-93a3-4621-8ce6-5f9b01aa428b",
  public_token: "0ea9cfab-d0c7-46ea-8a02-093d3ba473e7",
  created_at: Tue, 21 Jun 2022 14:05:41.490750000 -05 -05:00,
  updated_at: Tue, 21 Jun 2022 14:05:41.490750000 -05 -05:00,
  amount_cents: 590000,
  amount_currency: "COP",
  discarded_at: nil,
  conciliation_status: "pending",
  conciliation_payment_status: "payment_pending",
  log_data: nil>,
 #<SyPay::Order::Item:0x0000000148deffc8
  id: 931144,
  order_id: 799037,
  item_type: "SyLiquidationCo::Liquidation",
  item_id: 8632,
  slug: "6cb13ca6-99a6-4357-86b8-789b5bec272f",
  token: "6cb13ca6-99a6-4357-86b8-789b5bec272f",
  public_token: "5164851c-0c2e-404e-810a-bf432b895b51",
  created_at: Tue, 21 Jun 2022 14:05:42.336453000 -05 -05:00,
  updated_at: Tue, 21 Jun 2022 14:05:42.336453000 -05 -05:00,
  amount_cents: 214516696,
  amount_currency: "COP",
  discarded_at: nil,
  conciliation_status: "pending",
  conciliation_payment_status: "payment_pending",
  log_data: nil>,
 #<SyPay::Order::Item:0x0000000148defe10
  id: 931148,
  order_id: 799037,
  item_type: "SyLiquidationCo::Liquidation",
  item_id: 8635,
  slug: "59ecffe5-e348-4ca2-b2be-43cc91a06626",
  token: "59ecffe5-e348-4ca2-b2be-43cc91a06626",
  public_token: "57468a62-1eac-4624-8686-c942149c19ef",
  created_at: Tue, 21 Jun 2022 14:40:28.212336000 -05 -05:00,
  updated_at: Tue, 21 Jun 2022 14:40:28.212336000 -05 -05:00,
  amount_cents: 140197883,
  amount_currency: "COP",
  discarded_at: nil,
  conciliation_status: "pending",
  conciliation_payment_status: "payment_pending",
  log_data: nil>]
(END)

contract.employer.orders.last.order_items.last.item.contract.base_contract
=> #<SyRegistry::Contract:0x000000014d1c4b40
 id: 5376,
 employer_type: "Employer",
 employer_id: 2308,
 employee_type: "Employee",
 employee_id: 3462,
 kind_id: 2,
 start_date: Fri, 23 Oct 2020,
 planned_end_date: nil,
 end_date: Fri, 24 Jun 2022,
 test_period_end_date: Wed, 23 Dec 2020,
 working_day_start_time: Sat, 01 Jan 2000 08:00:00.000000000 -05 -05:00,
 working_day_end_time: Sat, 01 Jan 2000 14:00:00.000000000 -05 -05:00,
 payment_frequency: "biweekly",
 automatic_renewal: false,
 base_salary_cents: 105000000,
 base_salary_currency: "COP",
 is_old_contract: nil,
 platforms: {},
 monthly_worked_days: 30,
 created_at: Fri, 23 Oct 2020 00:00:00.000000000 -05 -05:00,
 updated_at: Thu, 23 Jun 2022 08:48:29.673760000 -05 -05:00,
 status: "active",
 discarded_at: nil,
 activation_date: Fri, 23 Oct 2020,
 creator_type: nil,
 creator_id: nil,
 log_data: nil>


 pry(main)> contract.employer.orders.last.order_items.last
=> #<SyPay::Order::Item:0x000000014dc65f68
 id: 931148,
 order_id: 799037,
 item_type: "SyLiquidationCo::Liquidation",
 item_id: 8635,
 slug: "59ecffe5-e348-4ca2-b2be-43cc91a06626",
 token: "59ecffe5-e348-4ca2-b2be-43cc91a06626",
 public_token: "57468a62-1eac-4624-8686-c942149c19ef",
 created_at: Tue, 21 Jun 2022 14:40:28.212336000 -05 -05:00,
 updated_at: Tue, 21 Jun 2022 14:40:28.212336000 -05 -05:00,
 amount_cents: 140197883,
 amount_currency: "COP",
 discarded_at: nil,
 conciliation_status: "pending",
 conciliation_payment_status: "payment_pending",
 log_data: nil>


 SyPay::Order::Item.find(931148).update(order_id: 503881)
 warning: 299 Elasticsearch-7.17.4-79878662c54c886ae89206c685d9f1051a9d6411 "Elasticsearch built-in security features are not enabled. Without authentication, your cluster could be accessible to anyone. See https://www.elastic.co/guide/en/elasticsearch/reference/7.17/security-minimal-setup.html to enable security."
 => true

 SyPay::Transaction.find(322540).order_items
=> [#<SyPay::Order::Item:0x00000001659fe0f0
  id: 814217,
  order_id: 503881,

  #<SyPay::Order::Item:0x0000000165f3fb40
  id: 814220,
  order_id: 503881,
  item_type: "SyPay::Service",


  #<SyPay::Order::Item:0x0000000165f3f208
  id: 814221,
  order_id: 503881,
  item_type: "SyPay::Service",
  item_id: 209112,


  order.order_items.first.transactions
  => [#<SyPay::Transaction:0x000000017aebe288
    id: 314400,
    payment_method_inscription_id: 48566,
    state: "rejected",
    reference: "23483f5c-507b-4e3d-918e-31be2a92a6cf",
    rejected_message: "Restricted card",
    amount_cents: 79700000,
    amount_currency: "COP",
    tax_amount_cents: 0,
    tax_amount_currency: "COP",
    slug: "9c3f6c70-a8b6-4d55-840f-ac43ef95d889",
    token: "9c3f6c70-a8b6-4d55-840f-ac43ef95d889",
    public_token: "9d73c944-ff57-471a-a2ff-94bf855be31f",
    created_at: Fri, 25 Feb 2022 08:55:34.271012000 -05 -05:00,
    updated_at: Fri, 25 Feb 2022 09:27:35.656002000 -05 -05:00,
    kind: "collection",
    installments: 4,
    confirmation_status: "RESTRICTED_CARD",
    discarded_at: nil,
    conciliation_status: "pending",
    raw_response: nil,
    authorization_code: nil,
    log_data: nil>,
   #<SyPay::Transaction:0x000000017af2bc70
    id: 319436,
    payment_method_inscription_id: 48566,
    state: "rejected",
    reference: "1f03e31d-158e-4b3e-9dcc-b23bba407dc3",
    rejected_message: "Restricted card",
    amount_cents: 79700000,
    amount_currency: "COP",
    tax_amount_cents: 0,
    tax_amount_currency: "COP",
    slug: "3ab54319-cebf-401d-8f96-1c47ffe9c902",
    token: "3ab54319-cebf-401d-8f96-1c47ffe9c902",
    public_token: "83d266d0-2a44-4877-ac85-17c76b39fb47",
    created_at: Wed, 02 Mar 2022 10:18:39.687729000 -05 -05:00,
    updated_at: Wed, 02 Mar 2022 10:24:21.450543000 -05 -05:00,
    kind: "collection",
    installments: 4,
    confirmation_status: "RESTRICTED_CARD",
    discarded_at: nil,
    conciliation_status: "pending",
    raw_response: nil,
    authorization_code: nil,
    log_data: nil>,
   #<SyPay::Transaction:0x000000017af2bb80
    id: 320589,
    payment_method_inscription_id: 7368,
    state: "rejected",
    reference: "7ed3ff8d-e60c-4cbf-be8d-393f7643a6a7",
    rejected_message: "Restricted card",
    amount_cents: 79700000,
    amount_currency: "COP",
    tax_amount_cents: 0,
    tax_amount_currency: "COP",
    slug: "849194af-e8cc-461f-bb21-1d30c1f8c001",
    token: "849194af-e8cc-461f-bb21-1d30c1f8c001",
    public_token: "db11d863-e3ff-4637-b3ff-c1240bef525a",
    created_at: Mon, 07 Mar 2022 08:28:31.206149000 -05 -05:00,
    updated_at: Mon, 07 Mar 2022 08:35:26.555886000 -05 -05:00,
    kind: "collection",
    installments: 1,
    confirmation_status: "RESTRICTED_CARD",
    discarded_at: nil,
    conciliation_status: "pending",
    raw_response: nil,
    authorization_code: nil,
    log_data: nil>,
   #<SyPay::Transaction:0x000000017af2b9f0
    id: 322540,
    payment_method_inscription_id: 53627,
    state: "paid",
    reference: "20928878858",
    rejected_message: nil,
    amount_cents: 91240000,
    amount_currency: "COP",
    tax_amount_cents: 2192600,
    tax_amount_currency: "COP",
    slug: "a449e0be-5123-48d9-b1aa-0f2ad2bb7021",
    token: "a449e0be-5123-48d9-b1aa-0f2ad2bb7021",
    public_token: "c4fb1d39-bb55-4099-936b-960af0b3232e",
    created_at: Thu, 17 Mar 2022 09:46:58.628887000 -05 -05:00,
    updated_at: Thu, 17 Mar 2022 09:47:17.133354000 -05 -05:00,
    kind: "collection",
    installments: 2,
    confirmation_status: nil,
    discarded_at: nil,
    conciliation_status: "pending",
    raw_response: nil,
    authorization_code: nil,
    log_data: nil>]
  (END)


  order.order_items.first.item.transactions
=> [#<SyPay::Transaction:0x00000001781f58c8
  id: 314400,
  payment_method_inscription_id: 48566,
  state: "rejected",
  reference: "23483f5c-507b-4e3d-918e-31be2a92a6cf",
  rejected_message: "Restricted card",
  amount_cents: 79700000,
  amount_currency: "COP",
  tax_amount_cents: 0,
  tax_amount_currency: "COP",
  slug: "9c3f6c70-a8b6-4d55-840f-ac43ef95d889",
  token: "9c3f6c70-a8b6-4d55-840f-ac43ef95d889",
  public_token: "9d73c944-ff57-471a-a2ff-94bf855be31f",
  created_at: Fri, 25 Feb 2022 08:55:34.271012000 -05 -05:00,
  updated_at: Fri, 25 Feb 2022 09:27:35.656002000 -05 -05:00,
  kind: "collection",
  installments: 4,
  confirmation_status: "RESTRICTED_CARD",
  discarded_at: nil,
  conciliation_status: "pending",
  raw_response: nil,
  authorization_code: nil,
  log_data: nil>,
 #<SyPay::Transaction:0x00000001781f5710
  id: 319436,
  payment_method_inscription_id: 48566,
  state: "rejected",
  reference: "1f03e31d-158e-4b3e-9dcc-b23bba407dc3",
  rejected_message: "Restricted card",
  amount_cents: 79700000,
  amount_currency: "COP",
  tax_amount_cents: 0,
  tax_amount_currency: "COP",
  slug: "3ab54319-cebf-401d-8f96-1c47ffe9c902",
  token: "3ab54319-cebf-401d-8f96-1c47ffe9c902",
  public_token: "83d266d0-2a44-4877-ac85-17c76b39fb47",
  created_at: Wed, 02 Mar 2022 10:18:39.687729000 -05 -05:00,
  updated_at: Wed, 02 Mar 2022 10:24:21.450543000 -05 -05:00,
  kind: "collection",
  installments: 4,
  confirmation_status: "RESTRICTED_CARD",
  discarded_at: nil,
  conciliation_status: "pending",
  raw_response: nil,
  authorization_code: nil,
  log_data: nil>,
 #<SyPay::Transaction:0x00000001781f5530
  id: 320589,
  payment_method_inscription_id: 7368,
  state: "rejected",
  reference: "7ed3ff8d-e60c-4cbf-be8d-393f7643a6a7",
  rejected_message: "Restricted card",
  amount_cents: 79700000,
  amount_currency: "COP",
  tax_amount_cents: 0,
  tax_amount_currency: "COP",
  slug: "849194af-e8cc-461f-bb21-1d30c1f8c001",
  token: "849194af-e8cc-461f-bb21-1d30c1f8c001",
  public_token: "db11d863-e3ff-4637-b3ff-c1240bef525a",
  created_at: Mon, 07 Mar 2022 08:28:31.206149000 -05 -05:00,
  updated_at: Mon, 07 Mar 2022 08:35:26.555886000 -05 -05:00,
  kind: "collection",
  installments: 1,
  confirmation_status: "RESTRICTED_CARD",
  discarded_at: nil,
  conciliation_status: "pending",
  raw_response: nil,
  authorization_code: nil,
  log_data: nil>,
 #<SyPay::Transaction:0x00000001781f53c8
  id: 322540,
  payment_method_inscription_id: 53627,
  state: "paid",
  reference: "20928878858",
  rejected_message: nil,
  amount_cents: 91240000,
  amount_currency: "COP",
  tax_amount_cents: 2192600,
  tax_amount_currency: "COP",
  slug: "a449e0be-5123-48d9-b1aa-0f2ad2bb7021",
  token: "a449e0be-5123-48d9-b1aa-0f2ad2bb7021",
  public_token: "c4fb1d39-bb55-4099-936b-960af0b3232e",
  created_at: Thu, 17 Mar 2022 09:46:58.628887000 -05 -05:00,
  updated_at: Thu, 17 Mar 2022 09:47:17.133354000 -05 -05:00,
  kind: "collection",
  installments: 2,
  confirmation_status: nil,
  discarded_at: nil,
  conciliation_status: "pending",
  raw_response: nil,
  authorization_code: nil,
  log_data: nil>]
(END)



order.order_items.first.item.transactions.last.transaction_linkeables
=> [#<SyPay::Transaction::Linkeable:0x000000017850f770
  id: 902135,
  _transaction_id: 322540,
  transaction_linkeable_type: "SyPay::Order::Item",
  transaction_linkeable_id: 814217,
  slug: "6531d493-5253-407d-b026-577e70a7c635",
  token: "6531d493-5253-407d-b026-577e70a7c635",
  public_token: "9000fea2-2616-4884-bfb1-b54298f0a7ad",
  created_at: Thu, 17 Mar 2022 09:46:58.644469000 -05 -05:00,
  updated_at: Thu, 17 Mar 2022 09:46:58.644469000 -05 -05:00,
  discarded_at: nil,
  log_data: nil>,
 #<SyPay::Transaction::Linkeable:0x0000000178552278
  id: 902136,
  _transaction_id: 322540,
  transaction_linkeable_type: "SyPay::Order::Item",
  transaction_linkeable_id: 814220,
  slug: "7fb35f7f-c7b3-408d-a86e-534aef7f7fe2",
  token: "7fb35f7f-c7b3-408d-a86e-534aef7f7fe2",
  public_token: "e550152f-171d-43f4-ad64-a337b54d282f",
  created_at: Thu, 17 Mar 2022 09:46:58.659007000 -05 -05:00,
  updated_at: Thu, 17 Mar 2022 09:46:58.659007000 -05 -05:00,
  discarded_at: nil,
  log_data: nil>,
 #<SyPay::Transaction::Linkeable:0x0000000178552098
  id: 902137,
  _transaction_id: 322540,
  transaction_linkeable_type: "SyPay::Order::Item",
  transaction_linkeable_id: 814221,
  slug: "0e486733-5831-49bf-b27f-3e8ec866ea68",
  token: "0e486733-5831-49bf-b27f-3e8ec866ea68",
  public_token: "e98f27a4-75a6-454c-adf4-ec1218203d49",
  created_at: Thu, 17 Mar 2022 09:46:58.672172000 -05 -05:00,
  updated_at: Thu, 17 Mar 2022 09:46:58.672172000 -05 -05:00,
  discarded_at: nil,
  log_data: nil>,
 #<SyPay::Transaction::Linkeable:0x0000000178551f08
  id: 902138,
  _transaction_id: 322540,
  transaction_linkeable_type: "SyPay::Order::Item",
  transaction_linkeable_id: 814225,
  slug: "a1c97bbd-4187-460d-9995-c715350683e2",
  token: "a1c97bbd-4187-460d-9995-c715350683e2",
  public_token: "2e49a2ab-1568-4e55-be76-fd30c148d6f0",
  created_at: Thu, 17 Mar 2022 09:46:58.684776000 -05 -05:00,
  updated_at: Thu, 17 Mar 2022 09:46:58.684776000 -05 -05:00,
  discarded_at: nil,
  log_data: nil>,
 #<SyPay::Transaction::Linkeable:0x0000000178551da0
  id: 902139,
  _transaction_id: 322540,
  transaction_linkeable_type: "SyPay::Order::Item",
  transaction_linkeable_id: 814227,
  slug: "1ba748d3-31d2-43ee-855b-06bb6ca719c1",
  token: "1ba748d3-31d2-43ee-855b-06bb6ca719c1",
  public_token: "3936097c-3af5-4ee5-aba7-6c4de301e53b",
  created_at: Thu, 17 Mar 2022 09:46:58.698463000 -05 -05:00,
  updated_at: Thu, 17 Mar 2022 09:46:58.698463000 -05 -05:00,
  discarded_at: nil,
  log_data: nil>]
(END)




 [434] pry(main)> order.order_items
=> [#<SyPay::Order::Item:0x000000017a333f30
  id: 814217,
  order_id: 503881,
  item_type: "SyPilaCo::Pila",
  item_id: 350273,
  slug: "f9d72ffc-5b79-46ef-84e1-f65eb1074010",
  token: "f9d72ffc-5b79-46ef-84e1-f65eb1074010",
  public_token: "3b1bce38-17cb-49c5-a3b0-0d0890e75d0e",
  created_at: Sun, 20 Feb 2022 02:25:24.462811000 -05 -05:00,
  updated_at: Sun, 20 Feb 2022 02:25:24.462811000 -05 -05:00,
  amount_cents: 79700000,
  amount_currency: "COP",
  discarded_at: nil,
  conciliation_status: "pending",
  conciliation_payment_status: "payment_success",
  log_data: nil>,
 #<SyPay::Order::Item:0x000000017a3470a8
  id: 814220,
  order_id: 503881,
  item_type: "SyPay::Service",
  item_id: 209111,
  slug: "3e88d9c5-771f-4c12-80cb-d30af4cf0f77",
  token: "3e88d9c5-771f-4c12-80cb-d30af4cf0f77",
  public_token: "163c1ee6-4a1b-49e8-a62b-3d3a8ee147f3",
  created_at: Sun, 20 Feb 2022 02:25:24.596942000 -05 -05:00,
  updated_at: Sun, 20 Feb 2022 02:25:24.596942000 -05 -05:00,
  amount_cents: 3650000,
  amount_currency: "COP",
  discarded_at: nil,
  conciliation_status: "pending",
  conciliation_payment_status: "payment_pending",
  log_data: nil>,
 #<SyPay::Order::Item:0x000000017a346ec8
  id: 814221,
  order_id: 503881,
  item_type: "SyPay::Service",
  item_id: 209112,
  slug: "f6a5ad74-4927-42cb-8f87-13b2ae903940",
  token: "f6a5ad74-4927-42cb-8f87-13b2ae903940",
  public_token: "cb731c66-1d8a-431d-bd3b-8fce39ecbf96",
  created_at: Sun, 20 Feb 2022 02:25:24.698709000 -05 -05:00,
  updated_at: Sun, 20 Feb 2022 02:25:24.698709000 -05 -05:00,
  amount_cents: 3650000,
  amount_currency: "COP",
  discarded_at: nil,
  conciliation_status: "pending",
  conciliation_payment_status: "payment_pending",
  log_data: nil>,
 #<SyPay::Order::Item:0x000000017a346d10
  id: 814225,
  order_id: 503881,
  item_type: "SyPay::Service",
  item_id: 209114,
  slug: "c74f0029-908b-4ead-8be4-bce43fd8f35f",
  token: "c74f0029-908b-4ead-8be4-bce43fd8f35f",
  public_token: "6dba8b1e-89ea-4d55-ba9e-e82642510e14",
  created_at: Sun, 20 Feb 2022 02:25:24.793347000 -05 -05:00,
  updated_at: Sun, 20 Feb 2022 02:25:24.793347000 -05 -05:00,
  amount_cents: 3650000,
  amount_currency: "COP",
  discarded_at: nil,
  conciliation_status: "pending",
  conciliation_payment_status: "payment_pending",
  log_data: nil>,
 #<SyPay::Order::Item:0x000000017a346630
  id: 814227,
  order_id: 503881,
  item_type: "SyPay::Products::TransactionCost",
  item_id: 1,
  slug: "e51d6cea-40f3-4fc3-9b60-d89dbd9b232f",
  token: "e51d6cea-40f3-4fc3-9b60-d89dbd9b232f",
  public_token: "a919b34c-4919-45cd-b80d-bc13a310df55",
  created_at: Sun, 20 Feb 2022 02:25:24.859631000 -05 -05:00,
  updated_at: Sun, 20 Feb 2022 02:25:24.859631000 -05 -05:00,
  amount_cents: 590000,
  amount_currency: "COP",
  discarded_at: nil,
  conciliation_status: "pending",
  conciliation_payment_status: "payment_pending",
  log_data: nil>,
 #<SyPay::Order::Item:0x000000017a346298
  id: 931148,
  order_id: 503881,
  item_type: "SyLiquidationCo::Liquidation",
  item_id: 8635,
  slug: "59ecffe5-e348-4ca2-b2be-43cc91a06626",
  token: "59ecffe5-e348-4ca2-b2be-43cc91a06626",
  public_token: "57468a62-1eac-4624-8686-c942149c19ef",
  created_at: Tue, 21 Jun 2022 14:40:28.212336000 -05 -05:00,
  updated_at: Thu, 23 Jun 2022 10:27:50.775004000 -05 -05:00,
  amount_cents: 140197883,
  amount_currency: "COP",
  discarded_at: nil,
  conciliation_status: "pending",
  conciliation_payment_status: "payment_pending",
  log_data: nil>]
(END)


 t = SyPay::Transaction.new
 l = SyPay::Transaction::Linkeable.new

 SyPay::Transaction::Linkeable.last.id
=> 1024938

SyPay::Transaction.last.id
=> 370351
