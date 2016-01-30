class AnalysisController < ApplicationController
  def index
    #ここにグラフ
    category = ['01/10','10/13','01/17','01/20']
    current_quantity = [80,80,85,87.5]
    current_quantity2 = [100,100,95,100]
    current_quantity3 = [85,90,85,90]

    @graph = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'H.Saitoさんのトレーニング推移')
      f.xAxis(categories: category)
      f.series(name: 'Push', data: current_quantity)
      f.series(name: 'Pull', data: current_quantity2)
      f.series(name: 'Leg', data: current_quantity3)
    end

    #円のパターン
    data = [['Push', 45.0],['Pull', 55.0],['Leg',30.0]]
    @graph_pie = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'トレーニング部位別バランス')
      f.series(name: 'レップス', data: data, type: 'pie')
    end

  end
end
