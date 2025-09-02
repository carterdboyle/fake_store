class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product_id, qty = 1)
    item = cart_items.find_or_initialize_by(product_id:)
    item.quantity = (item.quantity || 0) + qty.to_i
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
