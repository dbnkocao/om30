module Api
  module V1
    class MunicipesController < ApplicationController
      def index
        render json: Municipe.all
      end
    end
  end
end
