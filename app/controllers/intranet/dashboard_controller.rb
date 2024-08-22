require 'httparty'
require 'json'
class Intranet::DashboardController < Intranet::IntranetController
  include DashboardHelper
  before_action :authorize
  protect_from_forgery except: [:index, :update_index, :save_image, :relatorio]

  def index
    update_index()
  end
  
  def update_index
    property = "362753457" # aqui vai o código da propriedade do cliente no analytics, esse é da criativitta
    @client = "DICANALLI.COM.BR" # nome para o relatório
    if params[:start_date] && params[:end_date]
      @start_date = params[:start_date].to_s
      @end_date = params[:end_date].to_s
    else
      @start_date = Date.today.last_month.strftime('%Y-%m-%d').to_s
      @end_date = Date.today.strftime('%Y-%m-%d').to_s
      @all_dates = get_dates_between(@start_date, @end_date)
      @start_date = @start_date.to_s
      @end_date = @end_date.to_s
    end
    dimension = params[:dimension] ? params[:dimension].to_s : 'date'
    date = HTTParty.get('http://162.241.156.71:3000/date?property_id='+property+'&dimension='+dimension+'&start_date='+@start_date+'&end_date='+@end_date)
    page_view = HTTParty.get('http://162.241.156.71:3000/page_view?property_id='+property+'&start_date='+@start_date+'&end_date='+@end_date)
    event_count = HTTParty.get('http://162.241.156.71:3000/event_count?property_id='+property+'&start_date='+@start_date+'&end_date='+@end_date)
    new_users = HTTParty.get('http://162.241.156.71:3000/new_users?property_id='+property+'&start_date='+@start_date+'&end_date='+@end_date)
    origin = HTTParty.get('http://162.241.156.71:3000/origin?property_id='+property+'&start_date='+@start_date+'&end_date='+@end_date)
    landing_page = HTTParty.get('http://162.241.156.71:3000/landing_page?property_id='+property+'&start_date='+@start_date+'&end_date='+@end_date)
    page_path = HTTParty.get('http://162.241.156.71:3000/page_path?property_id='+property+'&start_date='+@start_date+'&end_date='+@end_date)
    city = HTTParty.get('http://162.241.156.71:3000/city?property_id='+property+'&start_date='+@start_date+'&end_date='+@end_date)
    country = HTTParty.get('http://162.241.156.71:3000/country?property_id='+property+'&start_date='+@start_date+'&end_date='+@end_date)
    device = HTTParty.get('http://162.241.156.71:3000/device?property_id='+property+'&start_date='+@start_date+'&end_date='+@end_date)
    @date = date
    array_date = []
    @date['rows'].map do |f| 
      ano =  ano_analytics(f['dimensionValues'][0]['value']) 
      mes =  mes_analytics(f['dimensionValues'][0]['value']) 
      dia =  dia_analytics(f['dimensionValues'][0]['value']) 
      if @date['dimensionHeaders'][0]['name'] == 'dateHour'
        hora =  hora_analytics(f['dimensionValues'][0]['value'])
        array_date += [[ano, mes, dia, hora, f['metricValues'][0]['value']]]
      else
        array_date += [[ano, mes, dia, f['metricValues'][0]['value']]]
      end
    end 
    @fix_array_date = fix_meses(@start_date, @end_date, array_date, dimension)
    @page_view_json = page_view
    @event_count_json = event_count
    @total_events = 0
    @event_count_json['rows'].map do |e|
      @total_events += e['metricValues'][0]['value'].to_i
    end
    @new_users_json = new_users
    @origin_json = origin
    @total_origins = 0
    @origin_json['rows'].map do |e|
      @total_origins += e['metricValues'][0]['value'].to_i
    end
    @page_path_json = page_path
    @total_pages_path = 0
    @page_path_json['rows'].map do |e|
      @total_pages_path += e['metricValues'][0]['value'].to_i
    end
    @landing_page_json = landing_page
    @total_pages = 0
    @landing_page_json['rows'].map do |e|
      @total_pages += e['metricValues'][0]['value'].to_i
    end
    @city_json = city
    @country_json = country
    @device_json = device
    @total_devices = 0
    @device_json['rows'].map do |e|
      @total_devices += e['metricValues'][0]['value'].to_i
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def relatorio(pdf, data_de, data_ate, client) # geração de relatorio para download
    pdf.image "#{Rails.root}/public/capa.jpg", width: pdf.bounds.width, height: pdf.bounds.height
    pdf.start_new_page(margin: 30)
    # dimension = params[:dimension] ? params[:dimension].to_s : 'date'
    # date = HTTParty.get('http://162.241.156.71:3000/date?property_id='+property+'&dimension='+dimension+'&start_date='+data_de+'&end_date='+data_ate)
    # pdf.image "#{Rails.root}/app/assets/images/logomarca-criativitta-menu.png", width: 130, height: 33, position: 405, vposition: 10
    pdf.fill_color "333333"
    pdf.formatted_text([{ :text => "TIPO: ", :styles => [:bold], :size => 10}, { :text => "ANÁLISE DE TRÁFEGO",:size => 10 }])
    # pdf.stroke_horizontal_rule
    pdf.move_down 10
    pdf.formatted_text([{ :text => "CLIENTE: ", :styles => [:bold], :size => 10}, { :text => client,:size => 10 }])
    pdf.move_down 10
    pdf.formatted_text([{ :text => "PERÍODO: ", :styles => [:bold], :size => 10}, { :text => "#{format_date(data_de.to_s)} até #{format_date(data_ate.to_s)}",:size => 10, :styles => [:uppercase]}])
    pdf.move_down 10
    pdf.image "#{Rails.root}/public/main_infos.png", width: pdf.bounds.width, position: :center
    pdf.move_down 10
    pdf.image "#{Rails.root}/public/dashboard.png", width: pdf.bounds.width
    pdf.move_down 20
    pdf.image "#{Rails.root}/public/origem.png", width: pdf.bounds.width, position: :center
    pdf.move_down 20
    total_width = pdf.bounds.width
    image_width = total_width / 2 - 10
    pdf.image "#{Rails.root}/public/visualizacoes.png", width: image_width
    pdf.bounding_box([image_width + 20, 352], width: image_width, height: 166) do
      pdf.image "#{Rails.root}/public/destino.png", width: image_width
    end
    pdf.move_down 20
    pdf.image "#{Rails.root}/public/cidade.png", width: image_width
    pdf.bounding_box([image_width + 20, 166], width: image_width, height: 166) do
      pdf.image "#{Rails.root}/public/pais.png", width: image_width
    end
  end

  def save_image
    image = [params[:main_infos], params[:dashboard], params[:origem], params[:visualizacoes], params[:destino], params[:cidade], params[:pais]]
    files = ["#{Rails.root}/public/main_infos.png", "#{Rails.root}/public/dashboard.png", "#{Rails.root}/public/origem.png", "#{Rails.root}/public/visualizacoes.png", "#{Rails.root}/public/destino.png", "#{Rails.root}/public/cidade.png", "#{Rails.root}/public/pais.png"]
    filename = params[:client].split('.')[0] + ".pdf"
    files.each_with_index do |f, index|
      File.open(f,'wb') do |f|
        f.write Base64.decode64(image[index].split(',').last)
      end
    end
    pdf = Prawn::Document.new(margin: 0)
    relatorio(pdf, params[:start_date], params[:end_date], params[:client])
    send_data pdf.render, filename: filename, type: 'application/pdf'
  end
  def property_params
    params.require(:property).permit(:id)
  end

end
