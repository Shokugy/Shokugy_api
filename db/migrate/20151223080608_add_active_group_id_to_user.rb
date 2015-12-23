class AddActiveGroupIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :active_group_id, :integer
  end
end
