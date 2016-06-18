class FoodCategoriesController < InheritedResources::Base
  before_action :login_required

  private

    def food_category_params
      params.require(:food_category).permit(:name, :no, :order)
    end
end

