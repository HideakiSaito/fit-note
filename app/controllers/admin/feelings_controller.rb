class Admin::FeelingsController < InheritedResources::Base
  before_action :login_required
  include AdminUtil
  before_action :admin_login_required
  private

    def feeling_params
      params.require(:feeling).permit(:name, :score, :memo)
    end
end
