class User < ActiveRecord::Base
  # association
  has_many :groups, through: :group_users
  has_many :group_users
  # MEMO: 多対多のhas_manyではなく、一対多のhas_manyを使用
  has_many :invites
  has_many :invite_users
  has_many :reviews
  has_many :notifications
  has_many :favorites
  has_many :comments

  # validation
  validates :name,
            :fb_id,
            presence: true

end
