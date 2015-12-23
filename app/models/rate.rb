class Rate < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :group
end
