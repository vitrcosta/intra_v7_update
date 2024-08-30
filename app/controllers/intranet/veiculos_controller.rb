class Intranet::VeiculosController < Intranet::IntranetController
  before_action :set_veiculo, only: %i[ show edit update destroy ]

  # GET /intranet/veiculos or /intranet/veiculos.json
  def index
    @veiculos = Veiculo.all
    respond_to do |format|
      format.html
      format.js
      format.xml { @veiculos = Veiculo.where.not(inativo: true) }
      format.json { render json: @veiculos = Veiculo.where.not(inativo: true)}
    end
  end

  # GET /intranet/veiculos/1 or /intranet/veiculos/1.json
  def show
    set_veiculo()
    respond_to do |format|
      format.html
      format.js
      format.xml { @veiculo }
      format.json { render json: @veiculo}
    end
  end

  # GET /intranet/veiculos/new
  def new
    @veiculo = Veiculo.new
    @veiculo.galleries.build
  end

  # GET /intranet/veiculos/1/edit
  def edit
    @veiculo = Veiculo.find(params[:id])
    @veiculo.galleries.build
  end

  # POST /intranet/veiculos or /intranet/veiculos.json
  def create
    @veiculo = Veiculo.new(veiculo_params)

    respond_to do |format|
      if @veiculo.save
        format.html { redirect_to intranet_veiculo_url(@veiculo), notice: "Veiculo was successfully created." }
        format.json { render :show, status: :created, location: @veiculo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @veiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /intranet/veiculos/1 or /intranet/veiculos/1.json
  def update
    respond_to do |format|
      if @veiculo.update(veiculo_params)
        format.html { redirect_to veiculos_url(), notice: "Veiculo was successfully updated." }
        format.json { render :show, status: :ok, location: @veiculo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @veiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /intranet/veiculos/1 or /intranet/veiculos/1.json
  def destroy
    @veiculo.destroy!

    respond_to do |format|
      format.html { redirect_to veiculos_url, notice: "Veiculo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_veiculo
      @veiculo = Veiculo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def veiculo_params
      params.require(:veiculo).permit(:ano, :foto_principal, :modelo, :preco, :observacao, :descricao, :quilometragem, :cor, :anofab, :combustivel, :procedencia, :inativo, :destaque, :codigo, :versao, :placa, :galleries_attributes => [:image, :id, :_destroy, :position ])
    end
end
