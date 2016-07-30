module AdminUtil 
  def admin_login_required
     login_error unless current_user.try(:administrator?)
  end

 def login_error 
   alert_message = "管理者権限が必要です"
   redirect_to "/", notice: alert_message 
 end
end
