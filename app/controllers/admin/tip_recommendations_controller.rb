class Admin::TipRecommendationsController < InheritedResources::Base
  include AdminUtil
  before_action :login_required
  before_action :admin_login_required

  private
    def tip_recommendation_params
      params.require(:tip_recommendation).permit(:name, :rate)
    end
end
