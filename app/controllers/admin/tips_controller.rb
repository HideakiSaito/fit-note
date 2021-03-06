class Admin::TipsController < InheritedResources::Base
  include AdminUtil
  before_action :login_required
  before_action :admin_login_required
  before_action :growl_setup ,only:[:index]
  private
  def growl_setup
    @tip = Tip.random_one
  end
  def tip_params
    params.require(:tip).permit(:tip_category_id, :tip_recommendation_id, :name, :description, :author)
  end
end
