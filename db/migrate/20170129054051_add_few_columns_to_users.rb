class AddFewColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string, null: false
    add_index :users, :username
    add_column :users, :avatar, :string
    add_column :users, :profile, :text
    add_column :users, :position, :string
    add_column :users, :occupation, :string
  end
end
