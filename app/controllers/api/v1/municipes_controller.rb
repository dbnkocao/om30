module Api
  module V1
    class MunicipesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        render json: Municipe.all
      end

      def show
        render json: Municipe.find(params[:id])
      end

      def create
        municipe = Municipe.new(municipe_params)
        if municipe.save
          render json: { message: "Munícipe criado com sucesso!" }, status: :created
        else
          render json: { errors: municipe.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def municipe_params
        params.require(:municipe).permit(:cpf, :email, :dt_nasc, :telefone, :nome, :foto,
                                         { :endereco_attributes => [:id, :cep, :logradouro, :numero, :complemento, :bairro, :municipio, :uf, :codigo_ibge] })
      end
    end
  end
end
