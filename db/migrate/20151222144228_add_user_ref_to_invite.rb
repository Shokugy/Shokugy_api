class AddUserRefToInvite < ActiveRecord::Migration
  def change
    add_reference :invites, :user, index: true
    add_foreign_key :invites, :users
  end
end
