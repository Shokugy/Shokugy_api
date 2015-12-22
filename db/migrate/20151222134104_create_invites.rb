class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.text :text
      t.references :restaurant, index: true

      t.timestamps null: false
    end
    add_foreign_key :invites, :restaurants
  end
end
