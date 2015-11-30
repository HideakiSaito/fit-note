class Item < ActiveRecord::Base
  belongs_to :part
  belongs_to :mode
  belongs_to :equipment

  #カスタムプロパティ
  def index_name
    self.part.name + " : " + self.name
  end

  #バリデーション
  validates :name ,presence: true

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
    where(part_id: 2)
  end

end
