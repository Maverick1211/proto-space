class AddIndexToImages < ActiveRecord::Migration[5.0]
  def change
    add_index :images, :role
  end
end
