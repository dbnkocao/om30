require "rails_helper"

RSpec.describe Municipe, type: :model do
  let(:municipe) { build(:municipe) }

  it "should be saved with valid arguments" do
    expect { municipe.save }.to change(Municipe, :count).by(1)
  end

  it "should not be valid without nome" do
    municipe.nome = nil
    expect(municipe).to_not be_valid
  end

  it "should not be valid without last name" do
    municipe.nome = FFaker::NameBR.first_name
    expect(municipe).to_not be_valid
  end

  it "should not be valid without cpf" do
    municipe.cpf = nil
    expect(municipe).to_not be_valid
  end

  it "should not be valid with a invalid cpf" do
    municipe.cpf = "111.111.111-11"
    expect(municipe).to_not be_valid
  end

  it "cpf should be unique" do
    municipe.save
    municipe2 = build(:municipe)
    municipe2.cpf = municipe.cpf
    expect(municipe2).to_not be_valid
  end

  it "should not be valid without email" do
    municipe.email = nil
    expect(municipe).to_not be_valid
  end

  it "should not be valid with an invalid email" do
    municipe.email = "bar.com"
    expect(municipe).to_not be_valid
  end

  it "should not be valid without dt_nasc" do
    municipe.dt_nasc = nil
    expect(municipe).to_not be_valid
  end

  it "should not be valid without telefone" do
    municipe.telefone = nil
    expect(municipe).to_not be_valid
  end

  it "should not be valid with invalid telefone" do
    municipe.telefone = FFaker::PhoneNumberBR.mobile_phone_number
    expect(municipe).to_not be_valid
  end

  it "should not be valid with age greater than 150" do
    municipe.dt_nasc = Date.today - 151.years
    expect(municipe).to_not be_valid
  end

  it "should not be valid with dt_nasc greater than current date" do
    municipe.dt_nasc = Date.today + 1.day
    expect(municipe).to_not be_valid
  end
end
