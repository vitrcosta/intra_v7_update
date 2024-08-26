class Intranet::VeiculosController < ApplicationController
  before_action :set_intranet_veiculo, only: %i[ show edit update destroy ]

  # GET /intranet/veiculos or /intranet/veiculos.json
  def index
    @intranet_veiculos = Intranet::Veiculo.all
  end

  # GET /intranet/veiculos/1 or /intranet/veiculos/1.json
  def show
  end

  # GET /intranet/veiculos/new
  def new
    @intranet_veiculo = Intranet::Veiculo.new
  end

  # GET /intranet/veiculos/1/edit
  def edit
  end

  # POST /intranet/veiculos or /intranet/veiculos.json
  def create
    @intranet_veiculo = Intranet::Veiculo.new(intranet_veiculo_params)

    respond_to do |format|
      if @intranet_veiculo.save
        format.html { redirect_to intranet_veiculo_url(@intranet_veiculo), notice: "Veiculo was successfully created." }
        format.json { render :show, status: :created, location: @intranet_veiculo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @intranet_veiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /intranet/veiculos/1 or /intranet/veiculos/1.json
  def update
    respond_to do |format|
      if @intranet_veiculo.update(intranet_veiculo_params)
        format.html { redirect_to intranet_veiculo_url(@intranet_veiculo), notice: "Veiculo was successfully updated." }
        format.json { render :show, status: :ok, location: @intranet_veiculo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @intranet_veiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /intranet/veiculos/1 or /intranet/veiculos/1.json
  def destroy
    @intranet_veiculo.destroy!

    respond_to do |format|
      format.html { redirect_to intranet_veiculos_url, notice: "Veiculo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intranet_veiculo
      @intranet_veiculo = Intranet::Veiculo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def intranet_veiculo_params
      params.require(:intranet_veiculo).permit(:ano, :modelo)
    end
end
