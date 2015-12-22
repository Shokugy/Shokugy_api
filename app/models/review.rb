class Review < ActiveRecord::Base
  # association
  belongs_to :restaurant
  belongs_to :user
end
