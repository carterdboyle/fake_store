class TightenCartItemDefaults < ActiveRecord::Migration[8.0]
  def change
    change_column_default :cart_items, :quantity, from: nil, to: 1
    add_index :cart_items, [:cart_id, :product_id], unique: true
  end
end
