class AddGroupRefToInvite < ActiveRecord::Migration
  def change
    add_reference :invites, :group, index: true
    add_foreign_key :invites, :groups
  end
end
