class UsersController < InheritedResources::Base
    def create
        if env['omniauth.auth'].present?
            # Facebookログイン
            @user  = User.from_omniauth(env['omniauth.auth'])
            result = @user.save(context: :facebook_login)
            fb       = "Facebook"
        else
            # 通常サインアップ
            @user  = User.new(strong_params)
            result = @user.save
            fb       = ""
        end
        if result
            sign_in @user
            flash[:success] = "#{fb}ログインしました。" 
            redirect_to @user
        else
            if fb.present?
                redirect_to auth_failure_path
            else
                render 'new'
            end
        end
    end
    
def destroy
  session[:user_id] = nil 
  redirect_to :home 
end

def sign_in user
  session[:user_id] = user.id
#  redirect_to root_url
end



    
  private

    def user_params
      params.require(:user).permit(:provider, :uid, :name, :email, :icon, :oauth_token, :oauth_expires_at)
    end
end

