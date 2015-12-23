class AddRateToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :rate, :float
  end
end
