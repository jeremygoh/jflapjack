class SetNullToFalseForUserIdAndPostIdInComments < ActiveRecord::Migration
  def change
      change_column :comments, :user_id, :integer, :null => false
      change_column :comments, :post_id, :integer, :null => false
  end
end
