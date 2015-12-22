class CreateInviteUsers < ActiveRecord::Migration
  def change
    create_table :invite_users do |t|
      t.references :invite, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :invite_users, :invites
    add_foreign_key :invite_users, :users
  end
end
