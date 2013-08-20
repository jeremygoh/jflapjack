class SetNullToFalseForCaptionInPosts < ActiveRecord::Migration
  def change
      change_column :posts, :caption, :string, null: false
  end
end
