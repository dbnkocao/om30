class MunicipesController < ApplicationController
  before_action :set_municipe, only: [:show, :edit, :update, :destroy]

  # GET /municipes
  # GET /municipes.json
  def index
    @municipes = Municipe.paginate(page: params[:page], per_page: 50)
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
        format.html { redirect_to @municipe, notice: "Municipe was successfully created." }
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
        format.html { redirect_to @municipe, notice: "Municipe was successfully updated." }
        format.json { render :show, status: :ok, location: @municipe }
      else
        format.html { render :edit }
        format.json { render json: @municipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /municipes/1
  # DELETE /municipes/1.json
  def destroy
    @municipe.destroy
    respond_to do |format|
      format.html { redirect_to municipes_url, notice: "Municipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_municipe
    @municipe = Municipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def municipe_params
    params.fetch(:municipe, {}).permit(:cpf, :email, :dt_nasc, :telefone, :status, :nome)
  end
end
