class CreateProtos < ActiveRecord::Migration[5.0]
  def change
    create_table :protos do |t|
      t.string :title, null: false
      t.string :catchcopy, null: false
      t.text :concept, null: false
      t.references :user, index: true
      t.timestamps
    end
  end
end
