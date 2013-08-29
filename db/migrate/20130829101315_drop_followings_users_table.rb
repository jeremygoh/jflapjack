class DropFollowingsUsersTable < ActiveRecord::Migration
  def change
    drop_table :followings_users
  end
end
