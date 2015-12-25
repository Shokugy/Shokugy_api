class AddPasswdToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :passwd, :string
  end
end
