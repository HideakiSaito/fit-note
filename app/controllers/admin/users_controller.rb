class Admin::UsersController < InheritedResources::Base
  before_action :login_required ,only:[:show,:index,:edit,:destroy]
  include AdminUtil
  before_action :admin_login_required

  def create
    if env['omniauth.auth'].present?
      # Facebookログイン
      @user  = User.from_omniauth(env['omniauth.auth'])
      result = @user.save(context: :facebook_login)
      fb       = "Facebook"
    else
      # 通常サインアップ
      @user  = User.new(user_params)
      result = @user.save
      fb       = ""
    end
    if result
      flash[:success] = "#{fb}ログインしました。" 
      sign_in @user
    else
      if fb.present?
        redirect_to auth_failure_path
      else
        render 'new'
      end
    end
  end
  def update
    @user = User.find params[:id]
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_user_path(@user), notice: 'user was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_user_path(@user) }
      else
        format.html { render edit_admin_user_path(@user) }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end
  def sign_in user
    session[:user_id] = user.id
    redirect_to :root
    #  redirect_to root_url
  end
  def show
    @user = User.find params[:id]
    #sign_in @user
  end
  def destroy
    session[:user_id] = nil 
    redirect_to :root 
  end
  def sign_in user
    session[:user_id] = user.id
    redirect_to :root
  end

  private

  def user_params
    params.require(:user).permit(:provider, :uid, :name, :email, :icon, :oauth_token, :oauth_expires_at, :password,:password_confirmation,:administrator)
  end
end

