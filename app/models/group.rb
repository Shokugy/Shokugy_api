class Group < ActiveRecord::Base
  authenticates_with_sorcery!

  # association
  has_many :users, through: :group_users
  has_many :group_users
  has_many :invites
  has_many :rates

  # validation
  validates :name,
            :password,
            :password_confirmation,
            presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 12 }
  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true

end
