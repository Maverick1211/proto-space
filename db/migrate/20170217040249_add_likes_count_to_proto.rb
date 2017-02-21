class AddLikesCountToProto < ActiveRecord::Migration[5.0]
  def change
    add_column :protos, :likes_count, :integer, default: 0
  end
end
