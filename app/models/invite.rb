class Invite < ActiveRecord::Base
  # association
  has_many :users, through: :invite_users
  has_many :invite_users
  # MEMO: 一対多
  belongs_to :user
  # MEMO: polymorphic
  belongs_to :inviteable, polymorphic: true

end
