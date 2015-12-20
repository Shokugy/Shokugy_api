class Group < ActiveRecord::Base
  # association
  has_many :users, through: :group_users
  has_many :group_users
end
