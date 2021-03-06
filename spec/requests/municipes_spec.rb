require "rails_helper"

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/municipes", type: :request do
  # Municipe. As you add validations to Municipe, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    municipe = build(:municipe).attributes
    municipe["endereco_attributes"] = build(:endereco).attributes
    municipe
  }

  let(:invalid_attributes) {
    build(:municipe, cpf: nil).attributes
  }

  describe "GET /index" do
    it "renders a successful response" do
      Municipe.create! valid_attributes
      get municipes_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      municipe = Municipe.create! valid_attributes
      get municipe_url(municipe)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_municipe_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      municipe = Municipe.create! valid_attributes
      get edit_municipe_url(municipe)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Municipe" do
        expect {
          post municipes_url, params: { municipe: valid_attributes }, as: :json
        }.to change(Municipe, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Municipe" do
        expect {
          post municipes_url, params: { municipe: invalid_attributes }, as: :json
        }.to change(Municipe, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:municipe) {
        create(:endereco).municipe
      }

      let(:new_attributes) {
        attributes = build(:municipe).attributes
        attributes["endereco_attributes"] = build(:endereco).attributes
        attributes["endereco_attributes"]["id"] = municipe.endereco.id
        attributes["id"] = municipe.id
        attributes
      }

      it "updates the requested municipe" do
        patch municipe_url(municipe), params: { municipe: new_attributes }, as: :json
        municipe.reload

        expect(municipe.cpf).to eq(new_attributes["cpf"])
        expect(municipe.email).to eq(new_attributes["email"])
        expect(municipe.dt_nasc).to eq(new_attributes["dt_nasc"])
        expect(municipe.telefone).to eq(new_attributes["telefone"])
        expect(municipe.nome).to eq(new_attributes["nome"])
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        municipe = Municipe.create! valid_attributes
        patch municipe_url(municipe), params: { municipe: invalid_attributes }, as: :json
        expect(response).to_not be_successful
      end
    end
  end
end
