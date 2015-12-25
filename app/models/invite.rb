class Invite < ActiveRecord::Base
  # association
  has_many :users, through: :invite_users
  has_many :invite_users
  has_many :comments
  belongs_to :user
  belongs_to :restaurant
  belongs_to :group

  # validation
  validates_presence_of :text, on: :create
  validates :text,
            :restaurant_id,
            presence: true
  validates :text, length: { maximum: 140 }

end
