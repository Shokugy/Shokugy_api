class Group < ActiveRecord::Base
  authenticates_with_sorcery!

  # association
 has_many :users, through: :group_users
 has_many :group_users
end
