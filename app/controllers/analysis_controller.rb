class AnalysisController < ApplicationController
    include ChartUtil
  def index
    #Big3 items id
    push_id = [1,2]
    pull_id = [4,18,5,6]
    leg_id = [9,10]
    
    #util
    analysis_initialize(nil)
    dates = chart_dates
    data_push = chart_data(push_id)
    data_pull = chart_data(pull_id)
    data_leg = chart_data(leg_id)
    @graph = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'H.Saitoさんのトレーニング推移')
      f.xAxis(categories: dates)
      f.series(name: 'Push', data: data_push)
      f.series(name: 'Pull', data: data_pull)
      f.series(name: 'Leg', data: data_leg)
    end

    #util
    analysis_initialize(nil)
    dates = chart_dates
    data_push = chart_data(push_id)
    data_pull = chart_data(pull_id)
    data_leg = chart_data(leg_id)
    @graph2 = LazyHighCharts::HighChart.new('graph') do |f|
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
