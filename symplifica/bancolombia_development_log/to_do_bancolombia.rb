1. Definir fecha de programación de debitos (inicio y fin) -> check parcial, preguntar si hay días no validos para la fecha de inicio

2. Implementar una validación o preguntar si es necesaria una validación para  que nunca se envien tarjetas de credito para inscribir (03)
Ya que No se manejan métodos de pago con tarjeta de crédito para la integración con bancolombia, solo cuentas bancarias de tipo collection

3. Código de respuesta para archivos de inscripción C07, Sumatoria de débitos no es numérico? porque si es un archivo de inscripcion no de debito,
que pasa cuando hay mas de un error en un archivo de inscripcion

4. Importantisimo el sistema de bancolombia no diferencia entre inscripción y recaudo de esta manera si se envia Inscripcion
con mod 'A' y el mismo dia se manda recaudo, el mod de recaudo debe ser 'B'  

5. Preguntar por este campo en el archivo de inscripción de cuentas:
    Dias de reintento reservado  -> no vamos a hacer reintentos por bancolombia sino internamente.

6. Preguntar por este campo en el archivo de inscripción de cuentas:
  reservado campo:
"- Criterios para la aplicación (Posición 19 a 20):"
 -> En la fecha de vencimiento
    Aunque debemos confirmar si tenemos validacion de base de datos o no

7. Preguntar por este campo en el archivo de inscripción de cuentas:
  "- No. de días (Posición 23 a 25):"
  -> este campo debe ser enviado en ceros (000)

8. Preguntar por este campo en el archivo de inscripción de cuentas:
  "Dia de Pagos- Día de pago (Posición 26 al 27):"
  -> Es opcional para convenios con validación en base de datos, por lo tanto este campo debe ser enviado en ceros (00)

9. Preguntar por este campo en el archivo de inscripción de cuentas:
  "- Débito parcial (Posición 28 a 30):"
  -> Sólo vamos a realizar débitos totales por lo tanto enviar con: 002: Débito para la cantidad total

10. Modificador de archivo (campo modifier en los modelos de generación de recaudo e inscripciones de recaudo)
El job generador busca los creados en el día si no encuentra ninguno asigna el modificador con la letra A por defecto
En caso que queramos crear uno para hacer pruebas:

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
#borrar archivo t.txt en syapp

11. Definir formato para nombre de archivo, (constante acronym)
-> por ahora se está manejando asi por indicación de edi, pero hay que preguntar en bancolombia
  acronym_fecha_created_modificador.txt
  INS
  REC
  PAG

12. Definir con Edi:
-> Cómo funcionan los jobs de inscripciones y recaudo, cada cuanto se deben llamar, lo mismo los de procesamiento de estados

13. Preguntar por este campo en el archivo de recaudos:
  Detalle 6	Valor del servicio principal

  -> es el transaction.ammount

14. Preguntar por este campo en el archivo de recaudos:
  Fecha de vencimiento

  -> es Time.zone.now


15. Las cuentas por ACH quedan activas para debitar en 2 días despues de la inscripción (ach son todos los clientes que no tienen su
   cuenta en bancolombia, por ejemplo un lciente que tenga cuenta en banco popular es ach)

  Definir con edi la programar el job de recaudos para cuentas ach con el fin que no interfiera con el job de inscripcion
  Ej: si ejecuto el job de inscripcion hoy para una cuenta ach y ese mismo dia mando el job de recaudo , la cuenta no estará activa para debitar

16. Preguntas para validación con bancolombia.
    Códigos de respuesta rechazados:

      Asobancaria 2001 y 2011	D03	Cuenta a debitar no es numérica	RECHAZADAS

      Asobancaria 2001 y 2011	D26	Nit del pagador no es un campo numérico	RECHAZADAS	RECHAZADOS

    Lineamiento para la generación archivo de recaudo:
	   Número de cuenta del cliente pagador: Alfanumérico	Obligatorio	De acuerdo a cada compañía
  	 Número de cuenta o de tarjeta de crédito del cliente pagador del servicio. Para el caso de tarjetas de crédito deben ser siempre Bancolombia.
     No Identificación del cliente Alfanumérico	Obligatorio

     Pregunta: Internamente validamos que los campos sean númericos/alfanumericos y que estos sean obligatorios u opcionales
     Esto garantiza que el archivo generado nunca tenga el error y por ende el código de respuesta nunca se aplique
     Como en este caso el código de respuesta y el lineamiento no coinciden, como debemos enviar estos campos
     númericos o alfanumericos?


17. Correo enviado a asesor de bancolombia
  Saludos Derly,
Nos podrías porfa ayudar con el archivo de pagos automáticos, el relacionado en los correos: Estructura de pagos PAB.xlsx tiene vínculos a otras tablas o archivos que no pudimos abrir.
Adicionalmente quisieramos saber como se debe enviar el archivo FORMATOINSCRIPCION PRODUCTO (34).xlsx ya que no conocemos el formato, deberia ser un CSV? tiene pautas de espacios en blanco o llenado con ceros?


Saludos Derly,
Adicionalmente quisiera saber si los campos obligatorios en el registro de detalle del documento Entrada_Asobancaria_2011_Con_Val.xlsx son los indicados en la pestaña:
Input Asobancaria 2011 españ,
O en la pestaña:
 Ent_Facturación_Asobancaria2011

Con pestaña me refiero a hoja de cálculo, según entiendo ambas se refieren al proceso de recaudo pero tienen información distinta (una en ingles y otra en español pero con valores diferentes),
 en este caso cuál de las dos debería utilizar
 Buenas Tardes Mauricio,

 Respuesta de Derly:
 1. Es la pestaña de facturación.
 2. En cuanto  a los pagos adjunto estructura.  los   los archivo deben ser en formato TXT  adjunto ejemplo.



Que hay que hacer:

1. Inscripciones de recaudos: carga y descarga:
      Archivo: Entrada_Asobancaria_2011_Con_Val.xlsx
      Pestaña: Entrada Nov Asobancaria 2011 -> Carga
2. Recaudo: carga y descarga: Modelo: SyBancolombia::Transaction::Payment > SyBancolombia::Collection::Transaction::Payment
      Archivo: Entrada_Asobancaria_2011_Con_Val.xlsx
      Pestaña: Ent_Facturación_Asobancaria2011 -> Carga


3. Inscripción de pagos (dispersiones) carga y descarga
4. Pagos (dispersion) carga y descarga (Dispersiones es el archivo pab)
  En bancolombia las dispersiones se deben inscribir mediante el FORMATOINSCRIPCION PRODUCTO (34)
  y Luego ejecturar la solicitud de dispersion con el formato PAB adjunto

  El modelo en la arquitectura de dispersiones en symplifica es SyBancolombia::Pay::Inscription::Payments para inscripciones de dispersion
  y SyBancolombia::Pay::Transaction::Payment para la solicitud de dispersion



-----------------------------------------------------------------------------------
Preguntas en el hilo del correo adjunto por fernand

1. Estamos creando la arquitectura y los procesos para inscripciones y recaudos,
sin embargo se van a manejar dispersiones en Bancolombia - los archivos de
"asobancaria 2011" sirven para dispersiones?

/R
  Para el envio de archivos de pagos, se ofrece la estructura PAB, que es la
  estructura que actualmente tienen vigente. Se anexa estructura de pago pagos
  para su revisión.

  Para el proceso de inscripción de cuentas, se anexa instructivo (Pag 4.)

2. Las cuentas bancarias registradas en Bancolombia necesitan un tope máximo a
debitar?

/R
  No hay topes máximos en cuentas Bancolombia, se pueden parametrizar
  topes como regla de seguridad dentro de la SVE.

3. Cómo se deben enviar los documentos de identidad (PE, PI, CD, PA)
cuando se registra una cuenta bancaria?

/R
Se deben enviar con el código 5,
Pasaporte.


4. Recaudos:
En el archivo de Asobancaria 2011 dice:

Para convenios con validación en base de datos, este campo debe ser enviado en
ceros. El valor a debitar se toma de la base de Facturación.?

/R
En el archivo de novedades, el valor se envía en ceros, porque se trata de una
novedad de inscripción al servicio de domiciliación (débito automático)

5. Cuáles son los códigos de respuesta de Bancolombia para registrar cuentas
bancarias y para realizar recaudos?


En este caso contamos con las repuestas para recaudo  y hacer referencia a
cualquier rechazo, (Se adjunta códigos de respuesta Recaudos)
para inscripción de cuentas parara pagos existen los códigos
de bancos que están adjunto en el formato de inscripción de productos .



revisar script de gateway bancolombia
