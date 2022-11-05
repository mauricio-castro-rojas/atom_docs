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
