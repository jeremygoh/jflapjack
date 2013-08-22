class CreateFollowerJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :followings do |t|
      t.references :user, index: true
    	t.references :following, index: true
    	t.timestamps
    end
  end
end
