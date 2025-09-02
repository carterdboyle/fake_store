class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product_id, qty = 1)
    qty = qty.to_i.clamp(1, 99)

    item = cart_items.find_or_initialize_by(product_id:)

    if item.new_record?
      # brand new line item: set exactly what the user asked for
      item.quantity = qty
    else
      # existing line item: bump, capped at 99
      item.quantity = [item.quantity.to_i + qty, 99].min
    end

    item.save!
    item
  end

  def absorb!(other_cart)
    other_cart.cart_items.find_each do |oi|
      add_product(oi.product_id, oi.quantity)
    end
    other_cart.destroy!
  end

  def total_quantity
    cart_items.sum(:quantity)
  end
end
