class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.float :rate
      t.references :restaurant, index: true
      t.references :group, index: true

      t.timestamps null: false
    end
    add_foreign_key :rates, :restaurants
    add_foreign_key :rates, :groups
  end
end
