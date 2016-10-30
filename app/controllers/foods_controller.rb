class FoodsController < InheritedResources::Base
  before_action :login_required
  after_action :add_voted, only:[:create]
  def index
    search
  end
  def search
    category_id = params[:category_id]
    @foods = Food.search(params[:q])
    @foods = @foods.where("food_category_id = ?",category_id) if category_id
    @foods = @foods.paginate(page: params[:page], per_page: 12)
    render "index"
  end
  def new
    #コピーの場合のロジック
    @food = Food.new
    if params[:copy_from] 
      @from = Food.find(params[:copy_from])
      @food = @from.dup #クローンのId抜き
      @food.name = "[copy]" +  @food.name
    end
    #pageからの定番メニュー追加ロジック
    if params[:page]
      page = Page.find params[:page]
      sort_key = page.date.strftime("%Y%m%d")
      diet_id = page.diet_id
      case params[:item].to_i
      when 1
        name = page.diet_memo_1
        protein = page.protein_1
        fat = page.fat_1
        carbohydrate = page.carbohydrate_1
        vegetable = page.vegetable_1
        sort_key += "-1"
      when 2
        name = page.diet_memo_2
        protein = page.protein_2
        fat = page.fat_2
        carbohydrate = page.carbohydrate_2
        vegetable = page.vegetable_2
        sort_key += "-2"
      when 3
        name = page.diet_memo_3
        protein = page.protein_3
        fat = page.fat_3
        carbohydrate = page.carbohydrate_3
        vegetable = page.vegetable_3
        sort_key += "-3"
      when 4
        name = page.diet_memo_4
        protein = page.protein_4
        fat = page.fat_4
        carbohydrate = page.carbohydrate_4
        vegetable = page.vegetable_4
        sort_key += "-4"
      when 5
        name = page.diet_memo_5
        protein = page.protein_5
        fat = page.fat_5
        carbohydrate = page.carbohydrate_5
        vegetable = page.vegetable_5
        sort_key += "-5"
      end
      @food.name = name
      @food.protein = protein
      @food.fat = fat
      @food.carbohydrate = carbohydrate
      @food.vegetable = vegetable
      @food.sort_key = sort_key
      @food.diet_id = diet_id
      @food.food_category_id = 1
      @food.diet_memo = sort_key + ":定番メニュー追加"
    end
  end

  def add_voted
    current_user.voted_foods << @food
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
