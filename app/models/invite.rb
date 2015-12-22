class Invite < ActiveRecord::Base
  # association
  has_many :users, through: :invite_users
  has_many :invite_users
  belongs_to :user
  belongs_to :restaurant

end
