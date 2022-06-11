#regenerate contract
contract_co = SyRegistryCo::Contract.where(base_contract: contract).last
if confirm
     spin do
       contract_template_service = ::SyRegistryCo::Template::ContractTemplateService.new
       file_name = contract_template_service.create_pdf(contract_co: contract_co)
     end
end

#regenerate acceptance data

if confirm
      spin do
        ::SyRegistryCo::Template::RegistrationAcceptanceLetter.new.create_pdf(contract_co: contract_co)
      end
end
