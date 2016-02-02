class AnalysisController < ApplicationController
  def index

   #get data
   dates = Page.order(:date).map(&:date)


    #ここにグラフ
    date = ['01/10','10/13','01/17','01/20']
    data_push = [80,80,85,87.5]
    data_pull = [100,100,95,100]
    data_leg = [85,90,85,90]

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
