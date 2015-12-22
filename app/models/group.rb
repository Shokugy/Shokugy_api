class Group < ActiveRecord::Base
  authenticates_with_sorcery!

  # validation
  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :name, uniqueness: true

  # association
 has_many :users, through: :group_users
 has_many :group_users

end
