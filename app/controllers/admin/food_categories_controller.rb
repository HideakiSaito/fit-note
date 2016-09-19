class Admin::FoodCategoriesController < InheritedResources::Base
  include AdminUtil
  before_action :login_required
  before_action :admin_login_required

  private

    def food_category_params
      params.require(:food_category).permit(:name, :no, :order)
    end
end
