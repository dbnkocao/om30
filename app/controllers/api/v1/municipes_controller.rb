module Api
  module V1
    class MunicipesController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_municipe, only: [:show, :update]

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

      def update
        if @municipe.update(municipe_params)
          render json: { message: "Munícipe atualizado com sucesso!" }, status: :created
        else
          render json: { errors: @municipe.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_municipe
        @municipe = Municipe.find(params[:id])
      end

      def municipe_params
        params.require(:municipe).permit(:cpf, :email, :dt_nasc, :telefone, :nome, :foto,
                                         { :endereco_attributes => [:id, :cep, :logradouro, :numero, :complemento, :bairro, :municipio, :uf, :codigo_ibge] })
      end
    end
  end
end
