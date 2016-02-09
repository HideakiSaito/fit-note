class Line < ActiveRecord::Base

  include RepsCalculator
  include EmailAddressChecker
  include Com

  belongs_to :page
  belongs_to :item
  belongs_to :mode

  validates :page, :no, :item, :mode , presence: true

  #スコープ
  scope :default_order , -> do
    order("page_id desc , no asc")
  end
  class <<self
    def get_now_no(page_id) 
      l = Line.where("page_id=?",page_id).order(:no)
      return 1 if l.size == 0
      l.last.no + 1 #あれば＋１
    end

    #JSONのインポート
    def import(file)
      s = File.read(file.path, :encoding => Encoding::UTF_8)
      JSON.parse( s ).each { |elem| line = Line.new(elem); line.save }
    end
  end

  def get_last_line
    now = page.date
    this = page.place
    prev_page = Page.where("place = ? and date < ?",this,now).order("date desc").first
    return nil unless prev_page

    prev_line = Line.joins(:page).where(pages:{id: prev_page.id}, item_id: item.id).first
    prev_line
  end

  def get_set_label(set)
    case set
    when 1 then
      w = weight_1 
      r = reps_1
      m = memo_1
    when 2 
      w = weight_2 
      r = reps_2
      m = memo_2
    when 3 
      w = weight_3 
      r = reps_3
      m = memo_3
    when 4 
      w = weight_4 
      r = reps_4
      m = memo_4
    when 5 
      w = weight_5 
      r = reps_5
      m = memo_5
    end
    w ||= ""
    r ||= ""
    m ||= ""
    "前回＞" + w.to_s + "/" + r.to_s + " : " + m
  end

  def print_label
    page.page_label + '_' + item.name + '_' + no.to_s
  end

  def this_max_reps
    line_max_reps(self)
  end
end
