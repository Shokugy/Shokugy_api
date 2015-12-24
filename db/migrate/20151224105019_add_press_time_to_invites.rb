class AddPressTimeToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :press_time, :datetime
  end
end
