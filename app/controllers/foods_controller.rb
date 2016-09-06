class FoodsController < InheritedResources::Base
  before_action :login_required
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


  # 投票
    def like
      @food = Food.find(params[:id])
      current_user.voted_foods << @food
      redirect_to :foods, notice: @food.name + "Like しました。"
    end

    # 投票削除
    def unlike
      @food = Food.find(params[:id])
      current_user.voted_foods.destroy(@food)
      redirect_to :foods, notice: @food.name + "Unlike しました。"
    end

    # 投票した記事
    def voted
      @foods = current_user.voted_foods
        .order("food_votes.created_at DESC")
        .paginate(page: params[:page], per_page: 15)
    end


  private
    def food_params
      params.require(:food).permit(:name, :diet_id, :calorie, :carbohydrate, :fat, :protein, :vegetable, :diet_memo,:food_category_id,:sort_key)
    end
end
