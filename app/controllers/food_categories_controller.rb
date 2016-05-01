class FoodCategoriesController < InheritedResources::Base

  private

    def food_category_params
      params.require(:food_category).permit(:name, :no, :order)
    end
end

