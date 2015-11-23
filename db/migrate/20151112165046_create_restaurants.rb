class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :name_kana
      t.text :link
      t.text :image_url
      t.string :postal_code
      t.text :addres
      t.timestamps null: false
    end
  end
end
