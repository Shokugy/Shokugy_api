class Group < ActiveRecord::Base
  authenticates_with_sorcery!

  # association
  has_many :users, through: :group_users
  has_many :group_users, dependent: :delete_all
  has_many :invites, dependent: :delete_all
  has_many :rates, dependent: :delete_all

  # validation
  validates :name,
            :passwd,
            # :password_confirmation,
            presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 12 }
  validates :passwd, length: { minimum: 3 }
  # validates :password, confirmation: true

end
