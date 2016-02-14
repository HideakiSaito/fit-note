class WelcomeController < ApplicationController
  # GET /trainings
  # GET /trainings.json
  def index
    @latest_page = Page.find(Page.maximum(:id))
    @recommend_1 = "しっかり栄養をとって休息をとりましょう。"
    @message = 
      case Time.now.hour
      when 2..4 then "こんな時間に。。。早く寝なさい！"
      when 5..6 then "おはようございます!早起きですね"
      when 7..9 then "おはようございます"
      when 10..12 then "お腹空きましたね"
      when 13..17 then "こんにちわ"
      when 18..20 then "こんばんわ！トレーニングの時間帯ですね"
      when 21..23 then "そろそろ寝ましょう！睡眠大事です。"
      when 0..1 then "早く寝てください。成長ホルモンが"
      else "no message"
      end
  end

  def about
  end

  def developer
  end

end
