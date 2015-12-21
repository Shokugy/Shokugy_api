class RenameColumnToRestaurant < ActiveRecord::Migration
  def change
    rename_column :restaurants, :addres, :address
  end
end
