class MunicipesController < ApplicationController
  before_action :set_municipe, only: [:show, :edit, :update, :destroy]

  # GET /municipes
  # GET /municipes.json
  def index
    @municipes = Municipe.search params[:query] || "*", page: params[:page], per_page: 20
  end

  # GET /municipes/1
  # GET /municipes/1.json
  def show
  end

  # GET /municipes/new
  def new
    @municipe = Municipe.new
  end

  # GET /municipes/1/edit
  def edit
  end

  # POST /municipes
  # POST /municipes.json
  def create
    @municipe = Municipe.new(municipe_params)

    respond_to do |format|
      if @municipe.save
        format.html { redirect_to municipes_url, notice: "Municipe cadastrado com sucesso." }
        format.json { render :show, status: :created, location: @municipe }
      else
        format.html { render :new }
        format.json { render json: @municipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /municipes/1
  # PATCH/PUT /municipes/1.json
  def update
    respond_to do |format|
      if @municipe.update(municipe_params)
        format.html { redirect_to municipes_url, notice: "Status Atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @municipe }
      else
        format.html { render :edit }
        format.json { render json: @municipe.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_municipe
    @municipe = Municipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def municipe_params
    params.fetch(:municipe, {})
      .permit(:cpf, :email, :dt_nasc, :telefone, :status, :nome, :foto,
              { :endereco_attributes => [:cep, :logradouro, :numero, :complemento, :bairro, :municipio, :uf, :codigo_ibge] })
  end

  def municipe_params_update
    params.fetch(:municipe, {})
      .permit(:status)
  end
end
