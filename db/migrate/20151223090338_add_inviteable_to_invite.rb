class AddInviteableToInvite < ActiveRecord::Migration
  def change
    add_reference :invites, :inviteable, polymorphic: true, index: true
  end
end
