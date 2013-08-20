class SetNullToFalseForTypeInPosts < ActiveRecord::Migration
  def change
      change_column :posts, :type, :string, null: false      
  end
end
