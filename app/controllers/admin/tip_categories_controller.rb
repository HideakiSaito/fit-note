class Admin::TipCategoriesController < InheritedResources::Base
  include AdminUtil
  before_action :login_required
  before_action :admin_login_required
  private
    def tip_category_params
      params.require(:tip_category).permit(:name)
    end
end
