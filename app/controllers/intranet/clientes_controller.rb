class Intranet::ClientesController < Intranet::IntranetController

  before_action :authorize, except: [:create_from_contact]
  helper_method :sort_column, :sort_direction
  protect_from_forgery except: [:create_from_contact]

  #STATUS DO CLIENTE:   Aberto:  1
  #                     Em atendimento: 2
  #                     Encerrado: 3
  #                     Fechado: 4

  def index


    sort_column = params[:sort]
    sort_direction = params[:direction]
    @de = params[:de]
    @ate = params[:ate]
    @atendido_por = params[:atendido_por]
    @status = params[:status]
    @search = params[:search]
    if sort_direction == 'desc'
      @clientes = Cliente.search(params[:search]).order("#{sort_column} desc").search_status(@status).search_atendente(@atendido_por).search_data(@de,@ate).page(params[:page])
    elsif sort_direction == 'asc'
      @clientes = Cliente.search(params[:search]).order("#{sort_column} asc").search_status(@status).search_atendente(@atendido_por).search_data(@de,@ate).page(params[:page])
    else
      @clientes = Cliente.search(params[:search]).order("created_at asc").search_status(@status).search_atendente(@atendido_por).search_data(@de,@ate).page(params[:page])
    end

    respond_to do |format|
      format.html
      format.js
      format.pdf do
        data_de = @de.nil? ? "01/01/2016" : @de
        data_ate = @ate.nil? ? Time.now.strftime("%d/%m/%Y") : @ate
        pdf = Prawn::Document.new
        relatorio(pdf, data_de, data_ate ,@clientes)
        send_data pdf.render, filename: 'relatorio.pdf', type: 'application/pdf'
      end


    end



  end

  def relatorio(pdf, data_de, data_ate, clientes) # geração de relatorio para download

    pdf.image "#{Rails.root}/app/assets/images/logomarca-criativitta-menu.png", width: 130, height: 33, position: 405, vposition: 10
    pdf.text "RELATÓRIO DE LEADS - CRIATIVITTÁ"
    pdf.stroke_horizontal_rule
    pdf.move_down 20
    pdf.text "Período: " + data_de + " até " + data_ate
    pdf.move_down 20
    pdf.font_size 8

    data = [["Data", 'Nome', 'Telefone', 'Email', 'Interesse', 'Atendente', 'Status']]

    clientes.each do |c|
      status = ""
      case c.status
      when 1
        status = "Aberto"
      when 2
        status = "Em atendimento"
      when 3
        status = "Encerrado"
      when 4
        status = "Fechado"
      end
      data += [[c.created_at.strftime("%d/%m/%Y"), c.nome, c.telefone, c.email, c.interesse, c.atendido_por, status]]
    end

    pdf.table(data, header: true, column_widths: [55] )

  end



  def show
    @cliente = Cliente.find(params[:id])
  end

  def new
    @cliente = Cliente.new
  end

  def edit
    @cliente = Cliente.find(params[:id])
  end

  # POST /clientes
  # POST /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)

    respond_to do |format|
      if @cliente.save
        format.html { redirect_to intranet_clientes_url, notice: 'Cliente foi criado com sucesso' }
        format.json { render action: 'show', status: :created, location: @cliente }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_from_contact
    # implementar de acordo com os parametros que vier da view
    @curso_id = params[:id][0]
    @categoria_id = params[:categoria_id][0]
    @cliente = Cliente.new(cliente_params)

    if @cliente.valid?
      if verify_recaptcha(model: @cliente)
        if @cliente.save
          ContatoMailer.contato(@cliente.nome,@cliente.telefone,@cliente.email,@cliente.mensagem, @cliente.curso).deliver
          redirect_to  "/cursos/#{@curso_id}?id=#{@categoria_id}", notice: "Mensagem enviada com successo!"
        end
      else
        flash[:error] = "Por favor marque a opção 'Não sou um robô' antes de enviar."
        redirect_to "/cursos/#{@curso_id}?id=#{@categoria_id}"

      end
    else
      flash[:alert] = 'Alguns campos não foram preenchidos corretamente.'
      redirect_to "/cursos/#{@curso_id}?id=#{@categoria_id}"
    end
  end

  def update
    @cliente = Cliente.find(params[:id])

    if @cliente.update_attributes(cliente_params)
      redirect_to intranet_clientes_url, notice: 'Cliente atualizado com sucesso.'
    else
      render action: "edit"
    end
  end

  def destroy
    @cliente = Cliente.find(params[:id])
    @cliente.destroy

    redirect_to intranet_clientes_url, notice: 'Cliente excluido com sucesso.'
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_cliente
    @cliente = Cliente.find(params[:id])
  end
  def sort_column
    params[:sort] || "id"
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cliente_params
    params.require(:cliente).permit(:nome, :email, :telefone, :mensagem, :interesse, :status, :atendido_por)
  end

end
