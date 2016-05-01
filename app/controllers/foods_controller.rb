class FoodsController < InheritedResources::Base
  def index
   @foods = Food.order(:diet_memo,:id)
  end
  private
    def food_params
      params.require(:food).permit(:name, :diet_id, :calorie, :carbohydrate, :fat, :protein, :vegetable, :diet_memo)
    end
end

