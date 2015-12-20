class SorceryCore < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name,            :null => false
      t.string :crypted_password
      t.string :salt

      t.timestamps
    end

    add_index :groups, :name, unique: true
  end
end