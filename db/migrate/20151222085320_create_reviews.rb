class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :review
      t.float :rate
      t.references :restaurant, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :reviews, :restaurants
    add_foreign_key :reviews, :users
  end
end
