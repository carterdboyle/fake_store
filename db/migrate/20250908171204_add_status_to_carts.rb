class AddStatusToCarts < ActiveRecord::Migration[8.0]
  def change
    add_column :carts, :status, :integer, null: false, default: 0 #0=active, 1=converted
    add_column :carts, :checked_out_at, :datetime
    add_index :carts, :status
  end
end
