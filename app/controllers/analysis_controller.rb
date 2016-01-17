class AnalysisController < ApplicationController
  def index
    #ここにグラフ
    category = [1,3,5,7]
    current_quantity = [1000,5000,3000,8000]

    @graph = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'H.Saitoさんのトレーニング推移')
      f.xAxis(categories: category)
      f.series(name: '日付', data: current_quantity)
    end

    #円のパターン
    data = [['DataA', 45.0],['DataB', 55.0]]
    @graph_pie = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'トレーニング部位別バランス')
      f.series(name: 'レップス', data: data, type: 'pie')
    end

  end
end
