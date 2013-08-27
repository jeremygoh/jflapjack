class AddCroppedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :cropped, :boolean
  end
end
