class Item < ActiveRecord::Base
  belongs_to :part
  belongs_to :mode
  belongs_to :equipment
  
  def index_name
     self.part.name + " : " + self.name
  end
  
end
