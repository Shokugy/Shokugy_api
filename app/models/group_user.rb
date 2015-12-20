class GroupUser < ActiveRecord::Base
  # association
  belongs_to :group
  belongs_to :user
end
