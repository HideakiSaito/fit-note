class FoodsController < InheritedResources::Base
  def index
    @foods = Food.all
  end
  private
    def food_params
      params.require(:food).permit(:name, :diet_id, :calorie, :carbohydrate, :fat, :protein, :vegetable, :diet_memo,:food_category_id,:sort_key)
    end
end

