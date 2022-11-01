2. Definir fecha de programación de debitos (inicio y fin) -> check parcial, preguntar si hay días no validos para la fecha de inicio

4. validar que nunca se envien tarjetas de credito para inscribir (03)

8. Código de respuesta para archivos de inscripción C07, Sumatoria de débitos no es numérico? porque si es un archivo de inscripcion no de debito

9. Importantisimo el sistema de bancolombia no diferencia entre inscripción y recaudo de esta manera si se envia Inscripcion
con mod 'A' y el mismo dia se manda recaudo, el mod de recaudo debe ser 'B'  


10. Hacer script que actualice los códigos de bancos en los seeds de sy_pay banks -> check
<< bogota_bank = ::SyPay::Bank.create!(codes: { ach: Faker::Number.number.to_s, davivienda: '01', bancolombia: '5600010' },  
  estos datos son los que usa el gateway de bancolombia para establecer los códigos de bancos a enivar al generador:
  bank_code:  inscription.payment_method.bank.codes['bancolombia'].to_s     

#script
bogota_bank = ::SyPay::Bank.where(name: 'BANCO DE BOGOTÁ').first
bogota_bank.codes.merge!(bancolombia: '5600010')
bogota_bank.save!

popular_bank = ::SyPay::Bank.where(name: 'BANCO POPULAR').first
popular_bank.codes.merge!(bancolombia: '5600023')
popular_bank.save!

corpbanca_bank = ::SyPay::Bank.where(name: 'BANCO CORPBANCA COLOMBIA S.A.').first #preguntar codigos de bancos itau
corpbanca_bank.codes.merge!(bancolombia: '5600065')
corpbanca_bank.save!

bancolombia_bank = ::SyPay::Bank.where(name: 'BANCOLOMBIA S.A.').first
bancolombia_bank.codes.merge!(bancolombia: '5600078')
bancolombia_bank.save!

citibank = ::SyPay::Bank.where(name: 'CITIBANK COLOMBIA').first
citibank.codes.merge!(bancolombia: '5600094')
citibank.save!

gnb_sudameris_bank = ::SyPay::Bank.where(name: 'BANCO GNB SUDAMERIS COLOMBIA').first
gnb_sudameris_bank.codes.merge!(bancolombia: '5600120')
gnb_sudameris_bank.save!

#helm_bank = ::SyPay::Bank.where(name: 'HELM BANK').first #preguntar... no está asociado en archivo
#helm_bank.codes.merge!(bancolombia: '5600120')
#helm_bank.save!

scotiabank = ::SyPay::Bank.where(name: 'SCOTIABANK COLPATRIA S.A.').first
scotiabank.codes.merge!(bancolombia: '5600191')
scotiabank.save!

occidente_bank = ::SyPay::Bank.where(name: 'BANCO DE OCCIDENTE').first
occidente_bank.codes.merge!(bancolombia: '5600230')
occidente_bank.save!

bancoldex = ::SyPay::Bank.where(name: 'BANCOLDEX').first
bancoldex.codes.merge!(bancolombia: '1031')
bancoldex.save!

caja_social_bank = ::SyPay::Bank.where(name: 'BANCO CAJA SOCIAL - BCSC S.A.').first
caja_social_bank.codes.merge!(bancolombia: '5600829')
caja_social_bank.save!

agrario_bank = ::SyPay::Bank.where(name: 'BANCO AGRARIO DE COLOMBIA S.A.').first
agrario_bank.codes.merge!(bancolombia: '1040')
agrario_bank.save!

davivienda_bank = ::SyPay::Bank.where(name: 'BANCO DAVIVIENDA S.A.').first
davivienda_bank.codes.merge!(bancolombia: '5895142')
davivienda_bank.save!

av_villas_bank = ::SyPay::Bank.where(name: 'BANCO AV VILLAS').first
av_villas_bank.codes.merge!(bancolombia: '6013677')
av_villas_bank.save!

wwb_bank = ::SyPay::Bank.where(name: 'BANCO WWB S.A.').first
wwb_bank.codes.merge!(bancolombia: '1053')
wwb_bank.save!

#BANCO CREDIFINANCIERA SA. = PROCREDIT?
procredit_bank = ::SyPay::Bank.where(name: 'BANCO PROCREDIT').first
procredit_bank.codes.merge!(bancolombia: '1558')
procredit_bank.save!

pichincha_bank = ::SyPay::Bank.where(name: 'BANCO PICHINCHA S.A.').first
pichincha_bank.codes.merge!(bancolombia: '1060')
pichincha_bank.save!

bancoomeva = ::SyPay::Bank.where(name: 'BANCOOMEVA').first
bancoomeva.codes.merge!(bancolombia: '1061')
bancoomeva.save!

finandina_bank = ::SyPay::Bank.where(name: 'BANCO FINANDINA S.A.').first
finandina_bank.codes.merge!(bancolombia: '1063')
finandina_bank.save!

#santander de negocios?
santander_bank = ::SyPay::Bank.where(name: 'BANCO SANTANDER').first
santander_bank.codes.merge!(bancolombia: '1065')
santander_bank.save!

cooperativo_coopcentral = ::SyPay::Bank.where(name: 'BANCO COOPERATIVO COOPCENTRAL').first
cooperativo_coopcentral.codes.merge!(bancolombia: '1066')
cooperativo_coopcentral.save!

#es este codigo el de itau o es el antiguo corpbanca
itau_bank = ::SyPay::Bank.where(name: 'BANCO ITAÚ').first
itau_bank.codes.merge!(bancolombia: '1014')
itau_bank.save!

nequi_bank = ::SyPay::Bank.where(name: 'NEQUI').first
nequi_bank.codes.merge!(bancolombia: '1507')
nequi_bank.save!

bbva = ::SyPay::Bank.where(name: 'BBVA').first
bbva.codes.merge!(bancolombia: '5600133')
bbva.save!

11. Hacer script que actualice los kinds en los seeds de sy pay -> check
puts '    # Kind'
savings_account_bank_kind = ::SyPay::PaymentMethod::AccountBank::Kind.create! name: 'savings', codes: { davivienda: 'CA', bancolombia: '01'}, is_active: true
regular_account_bank_kind = ::SyPay::PaymentMethod::AccountBank::Kind.create! name: 'regular', codes: { davivienda: 'CC', bancolombia: '02'}, is_active: true
daviplata_account_bank_kind = ::SyPay::PaymentMethod::AccountBank::Kind.create! name: 'daviplata', codes: { davivienda: 'DP'}, is_active: true

Script
savings = ::SyPay::PaymentMethod::AccountBank::Kind.where(name: 'savings').first
savings.update!(codes: { davivienda: 'CA', bancolombia: '01'})

regular = ::SyPay::PaymentMethod::AccountBank::Kind.where(name: 'regular').first
regular.update!(codes: { davivienda: 'CC', bancolombia: '02'})

  Estos se usan en el gateway de bancolombia para enviar el kind al generador
  account_bank_kind: inscription.payment_method.kind.codes['bancolombia'].to_s,

12. Preguntar dias de reintento reservado archivo de inscripcion de Cuentas -> no vamos a hacer reintentos por bancolombia sino internamente.

13. Incsripciones reservado campo . Preguntar bancolombia si tenemos validacion en base de datos
"- Criterios para la aplicación (Posición 19 a 20):
Campo numérico y obligatorio
Permite indicar las opciones de aplicación de los débitos a la cuenta del cliente pagador.
 - Es obligatorio para convenios con validación en base de datos. Las opciones son:
01. En la fecha de vencimiento de la factura
02. N días antes de la fecha de vencimiento (N = va de 001 a 005 días y se indica en el campo Nro. de días)."

"- No. de días (Posición 23 a 25):
Campo numérico y opcional
Permite indicar el número de días para la aplicación de los débitos a los clientes pagadores. Este campo es obligatorio en los siguientes casos:

 - Para convenios con validación en base de datos, cuando el campo "Criterios para la aplicación", esté diligenciado con la opción 02 ", es decir, N días antes de la fecha de vencimiento. Los valores son: 001 al 005.

 - Cuando no aplique  la opción anterior, este campo debe ser enviado en ceros (000)."


 Dia de Pagos"- Día de pago (Posición 26 al 27):
Campo numérico y opcional

Es opcional para convenios con validación en base de datos, por lo tanto este campo debe ser enviado en ceros (00)."


"- Débito parcial (Posición 28 a 30):
Campo numérico y obligatorio
 - Este campo es obligatorio para convenios con validación en base de datos. Las opciones son:

001: Débito de acuerdo con el saldo disponible (Aplica solo si el convenio tiene habilitado el parámetro de pago parcial).
002: Débito para la cantidad total

Nota: si el registro corresponde a una programación para cuentas de otros bancos, no aplica débito parcial, por lo tanto debe ser enviado con 002."


14. Crear un script para inscripciones en gateway BANCOLOMBIA
::SyPay::PaymentMethod::Inscription
      .joins(:gateway)
      .where(
        state: :created,
        kind: :collection,
        gateway: { gateway_type: SyPayCo::Gateway::Bancolombia.name }
      )


17. falta el modificador de archivo en el registro de encabezado de archivo
crear un registro para poder consultar:

#abre archivo y lo almacena en la variable file
file=::SyBancolombia::Collection::Inscription::Payment::File.new(modifier: 'B')
#<SyBancolombia::Collection::Inscription::Payment::File:0x00007fc9e266d948
 id: nil,
 status: "created",
 process_code: nil,
 last_download_date: nil,
 slug: nil,
 token: "e853281b-b650-4678-b7e6-108581e7d2e8",
 public_token: "60ecef4a-1bcf-4f6d-9904-8e3fe218eee6",
 discarded_at: nil,
 created_at: nil,
 updated_at: nil,
 modifier: "A",
 log_data: nil>

 text = "TEXT FILE 1111"

 File.write('t.txt', text) #crea archivo de texto para adjuntar a la instancia file

 f1 = File.new('t.txt', File::RDWR) #crea instancia de la clase File relacionando el archivo creado en el paso anterior
 file.file.attach( #adjunta el archivo
      io: f1,
      filename: "#{Time.now.strftime('%Y%m%d%H%M%S.txt')}"
    )
 file.save! #guarda en base de datos
 f1.close

 file2=::SyBancolombia::Collection::Inscription::Payment::File.new(modifier: 'C')


  f2 = File.new('t.txt', File::RDWR)
  file2.file.attach(
       io: f2,
       filename: "#{Time.now.strftime('%Y%m%d%H%M%S.txt')}"
     )
  file2.save!
  f2.close

day_range = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
generated_today = ::SyBancolombia::Collection::Inscription::Payment::File.where(created_at: day_range)
modifier = generated_today.order("created_at").last.modifier

#borrar archivo t.txt en syapp

18. definir nombre de archivo, constante acronym
estandar acronym fecha_created modificador
INS
REC
PAG
... penditente pab


21. Como funcionan los jobs de inscripciones y recaudo, cada cuanto se deben llamar , lo mismo los de procesamiento de ESTADOS




22. Archivo de recaudos:
Detalle
6	Valor del servicio principal 	14	Numérico	Obligatorio	12 enteros y 2 decimales.	"Corresponde al valor de la factura. Este campo obligatorio, no debe dejarse en blanco.
Nota: se puede diligenciar con valor en cero si el convenio tiene habilitado la opción de realizar pagos en cero o pagos superiores al valor de la factura."

transactiont.ammount

9	Fecha de vencimiento	8	Numérico	Obligatorio	AAAAMMDD	"Corresponde a la fecha de vencimiento de la factura.

Nota: si el registro corresponde a una programación para otros Bancos, este campo debe ser posterior a dos días hábiles."

Time.zone.now


23. Al programas los jobs de generator para inscription y collection preguntar como validar que se programe el job para una inscription de ach
que se supone debe empezar a debitarse dentro de dos dias

si ejecuto el job de inscripcion para una cuenta ach el inicio de programacion de debitos va a quedar disponible hasta dentro de dos dias
luego, si ejecuto el job de recaudo ese mismo dia, la fecha de ejecucion o fecha de expiracion que es el momento en el que se debita al clientes
tiene la fecha del instante en que se ejecuta el job, por lo tanto al ejecutarse el mismo dia que se inscribe abria conflicots porque la fecha de inicio esta
programada para dentro de dos dias pero el recaudo se esta ejecutando el mismo dia


24. Validacion con bancolombia.
Código de respuesta rechazado
Asobancaria 2001 y 2011	D03	Cuenta a debitar no es numérica	RECHAZADAS	RECHAZADOS

Asobancaria 2001 y 2011	D26	Nit del pagador no es un campo numérico	RECHAZADAS	RECHAZADOS

Archivo de entrada
	7	Número de cuenta del cliente pagador	17	Alfanumérico	Obligatorio	De acuerdo a cada compañía
  	Número de cuenta o de tarjeta de crédito del cliente pagador del servicio. Para el caso de tarjetas de crédito deben ser siempre Bancolombia.


    8	"No. Identificación
  del cliente"	16	Alfanumérico	Obligatorio	De acuerdo a cada compañía	Número de NIT o CC del cliente pagador del servicio. Este debe ser enviado sin dígito de verificación.


  en que punto durante la generacion de una archivo de inscripcion se actualizan estas tablas

  def sy_davivienda_inscription_payments
    ::SyDavivienda::Inscription::Payment.where(inscription: sy_pay_payment_method_inscriptions)
  end

  def sy_davivienda_collection_inscription_payments
    ::SyDavivienda::Collection::Inscription::Payment.where(inscription: sy_davivienda_inscription_payments)
  end
