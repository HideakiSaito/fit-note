class Training < ActiveRecord::Base
  belongs_to :item
  belongs_to :mode
end
