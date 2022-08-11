rails symplifica:console

def master_password
    [email.size, id, Time.zone.now.day].join("23")
end

id es el id en la tabla Admin

["fernando.ricaurte@symplifica.com".size, 5, Time.zone.now.day].join("23")
=> "32235238"

["mauricio.castro@symplifica.com".size, 5, Time.zone.now.day].join("23")

validar la facturacion
validar la Pila si ya tiene novedad de retiro , que hacer en esos casos
