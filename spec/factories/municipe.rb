FactoryBot.define do
  factory :municipe do
    nome { FFaker::NameBR.name }
    cpf { CpfUtils.cpf_formatado }
    email { FFaker::Internet.email }
    dt_nasc { FFaker::Time.between((Date.today - 150.years).strftime("%Y-%m-%d"), Date.today.strftime("%Y-%m-%d")) }
    telefone { FFaker::PhoneNumberBR.mobile_phone_number }
    status { rand(1..2) }
  end
end
