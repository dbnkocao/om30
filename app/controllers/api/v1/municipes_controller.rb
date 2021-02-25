module Api
  module V1
    class MunicipesController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_municipe, only: [:show, :update, :change_status]

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

      def change_status
        if @municipe.update(status: @municipe.status == "ativo" ? "inativo" : "ativo")
          render json: { message: "Status alterado com sucesso!" }, status: :created
        else
          render json: { message: @municipe.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def search
        result = Municipe.search(params[:query], page: params[:page], per_page: 8, match: :text_middle, order: { _uid: :desc })
        municipes = result.map { |municipe| MunicipeSerializer.new(municipe) }

        render json: { municipes: municipes, rows: result.total_count }
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
