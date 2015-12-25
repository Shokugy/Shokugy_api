class Comment < ActiveRecord::Base
  # association
  belongs_to :invite
  belongs_to :user

  # validation
  validates_presence_of :text, on: :create
  validation :text, length: { maximum: 140 }

end
