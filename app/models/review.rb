class Review < ActiveRecord::Base
  # association
  belongs_to :restaurant
  belongs_to :user

  # validation
  validates :review,
            :rate,
            :restaurant_id,
            presence: true
  validates :review, length: { maximum: 15_000 }

end
