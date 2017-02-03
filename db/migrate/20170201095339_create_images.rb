class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :image
      t.integer :role, default: 0, null: false
      t.references :proto, index: true
      t.timestamps
    end
  end
end
