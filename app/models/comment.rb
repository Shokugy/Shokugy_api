class Comment < ActiveRecord::Base
  # association
  belongs_to :invite
  belongs_to :user

  # validation
  validates :text,
            :invite_id,
            presence: true
  validates :text, length: { maximum: 140 }

end
