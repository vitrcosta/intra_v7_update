require 'httparty'
module DashboardHelper
  # def date_filter_helper(date)
  #   if date == 'ontem'
  #     'ao dia anterior'
  #   elsif date == '7_dias'
  #     'aos últimos 7 dias'
  #   else
  #     'aos últimos 30 dias'
  #   end
  # end

  # def date_filter_options(date)
  #   if date == 'ontem'
  #     '<p id="30_dias" class="update_index">Últimos 30 dias</p><p id="7_dias" class="update_index">Últimos 7 dias</p><p id="ontem" class="update_index_active">Ontem</p>'.html_safe
  #   elsif date == '7_dias'
  #     '<p id="30_dias" class="update_index">Últimos 30 dias</p><p id="7_dias" class="update_index_active">Últimos 7 dias</p><p id="ontem" class="update_index">Ontem</p>'.html_safe
  #   else
  #     '<p id="30_dias" class="update_index_active">Últimos 30 dias</p><p id="7_dias" class="update_index">Últimos 7 dias</p><p id="ontem" class="update_index">Ontem</p>'.html_safe
  #   end
  # end

  def get_dates_between(start_date_str, end_date_str)
    start_date = Date.strptime(start_date_str, '%Y-%m-%d')
    end_date = Date.strptime(end_date_str, '%Y-%m-%d')
    current_date = start_date
    date_array = []
    while current_date <= end_date do
      date_array += [[current_date.strftime('%Y'), current_date.strftime('%m'), current_date.strftime('%d'), "0"]]
      current_date += 1
    end
    return date_array
  end
  
  def fix_meses(start_date, end_date, array, dimension)
    meses_fixed = []
    selected_mes = get_dates_between(start_date, end_date)
      if dimension == "date"
        selected_mes.each do |f|
          @verify = false
          dia = []
          array.each_with_index do |o, index|
            if o[1] == f[1] && o[2] == f[2] 
              dia = [o]
              @verify = true
            end
          end
          if @verify == false
            meses_fixed += [f]
          else
            meses_fixed += dia
          end
        end
      else
        array.each do |o|
          meses_fixed += [o]
        end
      end

    meses = Hash.new { |hash, key| hash[key] = [] }
    meses_fixed.each do |data|
      ano, mes, dia = data
      meses[mes] << data
    end
    Rails.logger.info meses
    meses_fixed
  end
  
  def hora_analytics(date)
    date[8..9]
  end
  
  def dia_analytics(date)
    date[6..7]
  end

  def mes_analytics(date)
    date[4..5]
  end

  def ano_analytics(date)
    date[0..3]
  end

  def date_fix(date)
    date.gsub('-', ',')
  end

  def nome_mes(mes) 
    if mes == "01" || mes == "1"
      return "Janeiro"
    elsif mes == "02" || mes == "2"
      return "Fevereiro"
    elsif mes == "03" || mes == "3"
      return "Março"
    elsif mes == "04" || mes == "4"
      return "Abril"
    elsif mes == "05" || mes == "5"
      return "Maio"
    elsif mes == "06" || mes == "6"
      return "Junho"
    elsif mes == "07" || mes == "7"
      return "Julho"
    elsif mes == "08" || mes == "8"
      return "Agosto"
    elsif mes == "09" || mes == "9"
      return "Setembro"
    elsif mes == "10"
      return "Outubro"
    elsif mes == "11"
      return "Novembro"
    elsif mes == "12"
      return "Dezembro"
    end
  end

  def format_date(date)
    split_date = date.split('-')
    return "#{split_date[2]} de #{nome_mes(split_date[1])} de #{split_date[0]}"
  end

  def formatar_numero(numero)
    if numero.to_s.length > 3
      numero_formatado = numero.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\1.').reverse
      return numero_formatado
    else
      return numero
    end
  end
end
