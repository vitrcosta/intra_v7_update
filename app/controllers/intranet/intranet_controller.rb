class Intranet::IntranetController < ApplicationController
  layout "intranet"
  before_action :authorize
  protect_from_forgery

  protected
  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to intranet_login_url, alert: "Você precisa fazer o login para acessar!"
    end
  end

  def sort_column
    params[:sort] || "id"
  end

  def sort_direction
    params[:direction] || "desc"
  end
end
