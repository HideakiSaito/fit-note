class FoodsController < InheritedResources::Base
  def index
   @foods = Food.order(:food_category_id,:id)
  end
  private
    def food_params
      params.require(:food).permit(:name, :diet_id, :calorie, :carbohydrate, :fat, :protein, :vegetable, :diet_memo,:food_category_id)
    end
end

