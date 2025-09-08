class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :public_id, null: false
      t.references :user, null: false, foreign_key: true
      t.decimal :total, null: false, default: 0
      t.datetime :placed_at
      t.text :notes
      t.timestamps
    end
    add_index :orders, :public_id, unique: true
  end
end
