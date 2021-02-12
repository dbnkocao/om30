class MunicipesController < ApplicationController
  before_action :set_municipe, only: [:show, :edit, :update, :change_status]

  # GET /municipes
  # GET /municipes.json
  def index
    @municipes = Municipe.search params[:query] || "*", page: params[:page], per_page: 20
  end

  # GET /municipes/new
  def new
    @municipe = Municipe.new
    @municipe.endereco = Endereco.new
    render partial: "municipes/form_modal"
  end

  def show
    render partial: "municipes/show_modal"
  end

  def edit
    render partial: "municipes/form_modal"
  end

  # POST /municipes
  # POST /municipes.json
  def create
    @municipe = Municipe.new(municipe_params)

    respond_to do |format|
      if @municipe.save
        format.json { render json: { message: t("messages.municipe.created_with_success") }, status: :created }
      else
        format.json { render json: { message: (["#{t("errors.template.body")}<br>"] << @municipe.errors.full_messages).join("<br>") }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /municipes/1
  # PATCH/PUT /municipes/1.json
  def update
    respond_to do |format|
      if @municipe.update(municipe_params)
        format.json { render json: { message: t("messages.municipe.updated_with_success") }, status: :created }
      else
        format.json { render json: { message: (["#{t("errors.template.body")}<br>"] << @municipe.errors.full_messages).join("<br>") }, status: :unprocessable_entity }
      end
    end
  end

  def change_status
    @municipe.status = @municipe.status == "ativo" ? "inativo" : "ativo"

    respond_to do |format|
      if @municipe.update(municipe_params)
        format.html { redirect_to root_path, notice: "Status Atualizado com sucesso." }
        format.json { render json: { message: t("messages.municipe.updated_with_success") }, status: :created }
      else
        format.json { render json: { message: (["#{t("errors.template.body")}<br>"] << @municipe.errors.full_messages).join("<br>") }, status: :unprocessable_entity }
      end
    end
  end

  def get_list
    @municipes = Municipe.search "*", page: params[:page], per_page: 20
    render partial: "municipes/list"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_municipe
    @municipe = Municipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def municipe_params
    params.fetch(:municipe, {})
      .permit(:cpf, :email, :dt_nasc, :telefone, :nome, :foto,
              { :endereco_attributes => [:id, :cep, :logradouro, :numero, :complemento, :bairro, :municipio, :uf, :codigo_ibge] })
  end

  def municipe_params_update
    params.fetch(:municipe, {})
      .permit(:status)
  end
end
