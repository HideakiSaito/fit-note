class Item < ActiveRecord::Base
  belongs_to :part
  belongs_to :mode
  belongs_to :equipment
  has_many :item_votes, dependent: :destroy
  has_many :voters, through: :item_votes, source: :user

  #カスタムプロパティ
  def index_name
    self.part.name + " : " + self.name
  end
  #バリデーション
  validates :name ,presence: true

  scope :default, -> do
    #includes(:part)
  end

  scope :equipment_include , -> do
    includes(:equipment)
  end

  default_scope  -> do
    #includes(:part)
  end

  class << self
    def search(query)
      rel = order("part_id")
      if query.present?
        rel = rel.where("name LIKE ? ", "%#{query}%")
      end
      rel
    end
    #JSONのインポート
    def import(file)
      s = File.read(file.path, :encoding => Encoding::UTF_8)
      JSON.parse( s ).each do |elem|
        item = find_by(id: elem["id"]) || new
        item.assign_attributes(elem)
        item.save
      end
    end
  end

  #スコープ
  scope :inTheHome , ->  do
    where(equipment_id: [2,5] )
  end

  scope :in_the_gym, -> do
    where(equipment_id: [1,2,3,4]
         )
  end

  scope :on_chest, ->do
    where(part_id: 1)
  end

  scope :on_backs, ->do
    where(part_id: [2,3])
  end

  scope :on_legs, ->do
    where(part_id: 4)
  end
end
