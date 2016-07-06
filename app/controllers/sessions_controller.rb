class SessionsController < ApplicationController
  def update
    redirect_to :root
  end
  def create
    user = User.authenticate(params[:name], params[:password])
    if user
      session[:user_id] = user.id
      flash[:success] = "ログインしました。"
    else
      flash.alert = "名前とパスワードが一致しません"
    end
    redirect_to :root
  end

  def destroy
    session.delete(:user_id)
    redirect_to :root
  end
end
