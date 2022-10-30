rails symplifica:console

def master_password
    [email.size, id, Time.zone.now.day].join("23")
end

id es el id en la tabla Admin

["fernando.ricaurte@symplifica.com".size, 5, Time.zone.now.day].join("23")
=> "32235238"

["mauricio.castro@symplifica.com".size, 5, Time.zone.now.day].join("23")
