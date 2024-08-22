class Intranet::FolhetosController < Intranet::IntranetController
  before_action :authorize
  before_action :set_folheto, only: [:show, :edit, :update, :destroy]

  # GET /folhetos
  # GET /folhetos.json
  def index
    @folhetos = Folheto.all
  end

  # GET /folhetos/1
  # GET /folhetos/1.json
  def show
  end

  # GET /folhetos/new
  def new
    @folheto = Folheto.new
  end

  # GET /folhetos/1/edit
  def edit
  end

  # POST /folhetos
  # POST /folhetos.json
  def create
    @folheto = Folheto.new(folheto_params)

    respond_to do |format|
      if @folheto.save
        format.html { redirect_to new_intranet_folheto_path, notice: 'Folheto criado com sucesso.' }
        format.json { render :show, status: :created, location: @folheto }
      else
        format.html { render :new }
        format.json { render json: @folheto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /folhetos/1
  # PATCH/PUT /folhetos/1.json
  def update
    @folheto.remover_imagem_folheto(params[:remover_imagem_folheto])
    respond_to do |format|
      if @folheto.update(folheto_params)
        format.html { redirect_to edit_intranet_folheto_path("1"), notice: 'Folheto atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @folheto }
      else
        format.html { render :edit }
        format.json { render json: @folheto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folhetos/1
  # DELETE /folhetos/1.json
  def destroy
    @folheto.destroy
    respond_to do |format|
      format.html { redirect_to new_intranet_folheto_path, notice: 'Folheto deletado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folheto
      @folheto = Folheto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folheto_params
      params.require(:folheto).permit(:link_video, :imagem_folheto)
    end
end
