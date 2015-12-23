class RemoveColumnFromRestaurants < ActiveRecord::Migration
  def change
    remove_column :restaurants, :rate, :float
  end
end
