module ClientesHelper
  def cliente_status(status)
    case status
      when 1
        "<div title='Aberto' class='status_red'></div>".html_safe
      when 2
        "<div title='Em atendimento' class='status_yellow'></div>".html_safe
      when 3
        "<div title='Encerrado' class='status_blue'></div>".html_safe
      when 4
        "<div title='Fechado' class='status_green'></div>".html_safe
    end
  end


  def select_status_index(boolean)
    if boolean
      case params[:status]
        when '1'
          '<select class="form-control"><option value="1" selected>Aberto</option><option value="2">Em atendimento</option><option value="3">Encerrado</option><option value="4">Fechado</option><option value="">Todos</option></select>'.html_safe
        when '2'
          '<select class="form-control"><option value="1">Aberto</option><option value="2" selected>Em atendimento</option><option value="3">Encerrado</option><option value="4">Fechado</option><option value="">Todos</option></select>'.html_safe
        when '3'
          '<select class="form-control"><option value="1">Aberto</option><option value="2">Em atendimento</option><option value="3" selected>Encerrado</option><option value="4">Fechado</option><option value="">Todos</option></select>'.html_safe
        when '4'
          '<select class="form-control"><option value="1">Aberto</option><option value="2">Em atendimento</option><option value="3">Encerrado</option><option value="4" selected>Fechado</option><option value="">Todos</option></select>'.html_safe
        when ''
          '<select name="status" class="form-control"><option selected value> Todos </option><option value="1">Aberto</option><option value="2">Em atendimento</option><option value="3">Encerrado</option><option value="4">Fechado</option></select>'.html_safe
      end
    else
      '<select name="status" class="form-control"><option selected value> Todos </option><option value="1">Aberto</option><option value="2">Em atendimento</option><option value="3">Encerrado</option><option value="4">Fechado</option></select>'.html_safe
    end
  end
end
