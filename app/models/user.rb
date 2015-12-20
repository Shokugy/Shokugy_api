class User < ActiveRecord::Base
  # association
  has_many :groups, through: :group_users
  has_many :group_users
end
