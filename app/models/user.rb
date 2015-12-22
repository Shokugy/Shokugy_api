class User < ActiveRecord::Base
  # association
  has_many :groups, through: :group_users
  has_many :group_users
  has_many :invites, through: :invite_users
  has_many :invite_users
  has_many :reviews

end
