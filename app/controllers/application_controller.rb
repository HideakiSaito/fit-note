class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale
  class Forbidden < StandardError; end

  # 全リンクにlocale情報をセットする
  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  # リンクの多言語化に対応する
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

 rescue_from Forbidden ,with: :rescue_403

  private
 #ログインしないと使えない
 def login_required
   p "login_required"
    raise Forbidden  unless current_user
 end

 def rescue_403(exception)
   #render "welcome/index" ,status: 403,layout: "error" ,formats: [:html]
    flash.alert = "ログインしてください"
   render "welcome/index" 
 end
 
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
