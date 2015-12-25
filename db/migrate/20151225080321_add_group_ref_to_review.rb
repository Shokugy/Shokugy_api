class AddGroupRefToReview < ActiveRecord::Migration
  def change
    add_reference :reviews, :group, index: true
    add_foreign_key :reviews, :groups
  end
end
