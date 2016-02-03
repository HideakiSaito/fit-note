class AnalysisController < ApplicationController
  def index
    #Big3 items id
    push_id = [1,2]
    pull_id = [4,5,6]
    leg_id = [9,10,18]
    #get data
##    dates = Page.order(:date).map(&:date)
    dates = Page.order(:date).map do |page|
      page.date.strftime("%y/%m/%d(%a)") + "[" + page.place + "]"
    end
    #グラフdata push
    data_push = Page.order(:date).map do |page|
      push_line = page.lines.where(item_id: push_id).first
      if push_line != nil
        push_line.this_max_reps.to_i
      else
        0
      end
    end
    #グラフdata pull
    data_pull = Page.order(:date).map do |page|
      pull_line = page.lines.where(item_id: pull_id).first
      if pull_line != nil
        pull_line.this_max_reps.to_i
      else
        0
      end
    end
    #グラフdata leg 
    data_leg = Page.order(:date).map do |page|
      leg_line = page.lines.where(item_id: leg_id).first
      if leg_line != nil
        leg_line.this_max_reps.to_i
      else
        0
      end
    end

    @graph = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'H.Saitoさんのトレーニング推移')
      f.xAxis(categories: dates)
      f.series(name: 'Push', data: data_push)
      f.series(name: 'Pull', data: data_pull)
      f.series(name: 'Leg', data: data_leg)
    end

    #円のパターン
    data = [['Push', 45.0],['Pull', 55.0],['Leg',30.0]]
    @graph_pie = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'トレーニング部位別バランス')
      f.series(name: 'レップス', data: data, type: 'pie')
    end

  end
end
