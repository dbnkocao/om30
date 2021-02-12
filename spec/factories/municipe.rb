FactoryBot.define do
  factory :municipe do
    nome { FFaker::NameBR.name }
    cpf { CpfUtils.cpf_formatado }
    email { FFaker::Internet.email }
    dt_nasc { FFaker::Time.between((Date.today - 150.years).strftime("%Y-%m-%d"), Date.today.strftime("%Y-%m-%d")) }
    telefone { FFaker::String.from_regexp(Municipe::TELEFONE_PATTERN) }
    status { rand(0..1) }
  end
end
