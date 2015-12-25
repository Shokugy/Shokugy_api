class Notification < ActiveRecord::Base
  # association
  belongs_to :user

  # scope
  scope :timeline_notifications, ->(current_user){ where(user_id: current_user.id).order("created_at DESC") }

end
