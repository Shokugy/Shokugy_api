class RemoveUidFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :uid, :string
    add_column :users, :fb_id, :string, unique: true
  end
end
