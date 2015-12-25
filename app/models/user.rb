class User < ActiveRecord::Base
  # association
  has_many :groups, through: :group_users
  has_many :group_users, dependent: :delete_all
  # MEMO: 多対多のhas_manyではなく、一対多のhas_manyを使用
  has_many :invites, dependent: :delete_all
  has_many :invite_users, dependent: :delete_all
  has_many :reviews, dependent: :delete_all
  has_many :notifications, dependent: :delete_all
  has_many :favorites, dependent: :delete_all
  has_many :comments, dependent: :delete_all

  # validation
  validates :name,
            :fb_id,
            presence: true

end
