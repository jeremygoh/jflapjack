class SetNullToFalseForBodyInComments < ActiveRecord::Migration
  def change
      change_column :comments, :body, :string, null: false
  end
end
