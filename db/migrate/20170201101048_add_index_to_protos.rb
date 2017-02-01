class AddIndexToProtos < ActiveRecord::Migration[5.0]
  def change
    add_index :protos, :title
  end
end
