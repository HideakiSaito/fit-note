class Admin::DietsController < InheritedResources::Base
  before_action :login_required
  include AdminUtil
  before_action :admin_login_required

  private

    def diet_params
      params.require(:diet).permit(:name)
    end
end

