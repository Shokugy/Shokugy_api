class Rate < ActiveRecord::Base
  # association
  belongs_to :restaurant
  belongs_to :group

end
