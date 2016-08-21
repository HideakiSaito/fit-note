class Admin::ConditionsController < InheritedResources::Base
  before_action :login_required
  include AdminUtil
  before_action :admin_login_required
  private

    def condition_params
      params.require(:condition).permit(:name, :score, :memo)
    end
end
