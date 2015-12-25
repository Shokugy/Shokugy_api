class Review < ActiveRecord::Base
  # association
  belongs_to :restaurant
  belongs_to :user

  # validation
  validates :review,
            :rate,
            presence: true
  validation :review, length: { maximum: 15_000 }

end
