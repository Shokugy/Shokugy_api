class InviteUser < ActiveRecord::Base
  # association
  belongs_to :invite
  belongs_to :user

end
