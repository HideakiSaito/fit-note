class Admin::FoodsController < InheritedResources::Base
  include AdminUtil
  before_action :login_required
  before_action :admin_login_required
  after_action :add_voted, only:[:create]

  def index
    @foods = Food.all
  end
  def new
    @food = Food.new
    if params[:copy_from] #コピーの場合のロジック
      @from = Food.find(params[:copy_from])
      @food = @from.dup #クローンのId抜き
      @food.name = "[copy]" +  @food.name
    end
  end
  def add_voted
    current_user.voted_foods << @food
  end
  private
    def food_params
      params.require(:food).permit(:name, :diet_id, :calorie, :carbohydrate, :fat, :protein, :vegetable, :diet_memo,:food_category_id,:sort_key)
    end
end
