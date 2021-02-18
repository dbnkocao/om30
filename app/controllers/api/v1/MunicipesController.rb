module Api
  module V1
    class MunicipesController < ApplicationController
      def index
        render json: Municipe.all.as_json
      end
    end
  end
end
