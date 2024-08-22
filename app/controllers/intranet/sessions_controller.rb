class Intranet::SessionsController < Intranet::IntranetController
  skip_before_action :authorize
  layout "intranet_login"

  def index
    @sessions = Session.all
  end


  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:user_name] = user.name
      redirect_to intranet_dashboard_index_path, alert: "Login efetuado com sucesso!"
    else
      redirect_to intranet_login_url, alert: "Usuário ou Senha inválidos!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to intranet_login_url, alert: "Você saiu com sucesso!"
  end
end
