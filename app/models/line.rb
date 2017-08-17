class Line < ActiveRecord::Base
  include RepsCalculator
  include EmailAddressChecker
  belongs_to :page
  belongs_to :item
  belongs_to :mode
  validates :page, :no, :item, :mode , presence: true
  #スコープ
  scope :default_order , -> do
    order("page_id desc , no asc")
  end
  scope :default, -> do
    includes(:item)
  end
  default_scope  -> do
    #includes(:item).inculdes(:part)
    includes(:item)
  end
  class <<self
    #行NOを採番する
    def get_now_no(page_id) 
      l = Line.where("page_id=?",page_id).order(:no)
      return 1 if l.size == 0
      l.last.no + 1 #あれば＋１
    end
    #JSONのインポート
    def import(file)
      s = File.read(file.path, :encoding => Encoding::UTF_8)
      JSON.parse( s ).each do |elem| 
        line = find_by(id: elem["id"]) || new 
        line.assign_attributes(elem)
        line.save 
      end
    end
  end
  #同一トレーニング場所で前回の同種目の記録を取得する
  def get_last_line
    prev_page = get_prev_page page #最初に前回のページを見る
    prev_line = nil
    until prev_line
      prev_line = Line.joins(:page).where(pages:{id: prev_page.id}, item_id: item.id).first
      prev_line = LineDecorator.decorate(prev_line) if prev_line
      return prev_line if prev_line #前回のページに同じ種目があれば返す
      prev_page = get_prev_page prev_page ##前々回のページを見る、繰り返す
      return nil unless prev_page #前回のトレーニングなければnil
    end
  end
  def get_prev_page(x_page)
    prev_page = Page.where("place = ? and date < ?",x_page.place ,x_page.date).order("date desc").first
  end
  #統計データ用にレップス合計を取得
  def get_sum_reps
    reps_1.to_i + reps_2.to_i + reps_3.to_i + reps_4.to_i + reps_5.to_i + reps_6.to_i + reps_7.to_i + reps_8.to_i + reps_9.to_i + reps_0.to_i #nil.to_i => 0 を利用
  end
  #前回、前々回とかの記録を簡単に見せるように
  def get_set_label(set)
    case set
     when 1 then  w = weight_1; r = reps_1; m = memo_1;
     when 2 then  w = weight_2; r = reps_2; m = memo_2;
     when 3 then  w = weight_3; r = reps_3; m = memo_3;
     when 4 then  w = weight_4; r = reps_4; m = memo_4;
     when 5 then  w = weight_5; r = reps_5; m = memo_5;
     when 6 then  w = weight_6; r = reps_6; m = memo_6;
     when 7 then  w = weight_7; r = reps_7; m = memo_7;
     when 8 then  w = weight_8; r = reps_8; m = memo_8;
     when 9 then  w = weight_9; r = reps_9; m = memo_9;
     when 0 then  w = weight_0; r = reps_0; m = memo_0;
    end
    w ||= ""; r ||= "";  m ||= ""; #nil => ""
    page.date.strftime("%m/%d(%a)") + "＞" + w.to_s + "/" + r.to_s + " : " + m
  end
  #ラベル出力用
  def print_label
    page.page_label + '_' + item.name + '_' + no.to_s
  end
  #このトレーニング日での最大挙上重量を計算して返す
  def this_max_reps
    line_max_reps(self)
  end
end
