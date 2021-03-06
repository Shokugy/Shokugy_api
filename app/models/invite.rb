class Invite < ActiveRecord::Base
  # association
  has_many :users, through: :invite_users
  has_many :invite_users, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  belongs_to :user
  belongs_to :restaurant
  belongs_to :group

  # validation
  validates_presence_of :text, on: :create
  validates :text,
            :restaurant_id,
            presence: true
  validates :text, length: { maximum: 140 }

  # scope
  scope :timeline_invites, ->(current_user){ where(group_id: current_user.active_group_id).order("created_at DESC") }

end
