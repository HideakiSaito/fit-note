class WelcomeController < ApplicationController
  include ChartUtil
  def index
    latest_date = Page.maximum(:date) #最新日
    @latest_page = Page.where(date: latest_date).first
    @recommend_1 = "しっかり栄養をとって休息をとりましょう。"
    @recommend_2 = "焦らず重量は２kg刻みで６〜８repsで調整しましょう。フォームを大切に。１２週間に一回はレイオフを設けましょう。"
    @greeting = get_greeting
    @chart_gym = get_chart_gym
    @cheer = latest_page_finished ? "お疲れ様でした。" : "頑張りましょう"
  end

  def about
  end

  def developer
  end

  def latest_page_finished
    reps_sum = @latest_page.lines.collect do 
      |line| line.get_sum_reps 
    end.sum
    reps_sum != 0 #最新ページのトレーニング一回もやってなかったら 
  end

  def get_greeting
      case Time.current.hour #now だとUTC
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

  def get_chart_gym
    #Big3 items id
    push_id = [1,2]
    pull_id = [4,18,5,6]
    leg_id = [9,10]
    analysis_initialize("ジム")#ChartUtilを利用
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'ジムでのトレーニング推移')
      f.xAxis(categories: chart_dates)
      f.series(name: 'Push', data: chart_data(push_id))
      f.series(name: 'Pull', data: chart_data(pull_id))
      f.series(name: 'Leg', data: chart_data(leg_id))
    end
  end

end
