class CheckoutCart
  class Error < StandardError; end

  def self.call(user:)
    new(user:, cart:).call
  end

  def initialize(cart:, user:)
    @cart = cart
    @user = user
    raise Error, "Cart does not belong to user" if @cart.user_id && @cart.user_id != @user.id
  end

  def call
    raise Error, "Cart is empty" if @cart.cart_items.empty?

    ActiveRecord::Base.transaction do
      order = @user.orders.create!
      items = @cart.cart_items.includes(:product).sort_by(&:product_id)

      items.each do |ci|
        product = ci.product
        quantity = ci.quantity

        product.decrement_if_available!(quantity)

        order.order_items.create!(
          product_id: product.id,
          product_name: product.title,
          unit_price: product.price,
          quantity: quantity,
          total: product.price * quantity,
        )
    end

    # Recompute order total from items
    order.update!(
      total: order.order_items.sum(:total),
      placed_at: Time.current
    )

    @cart.cart_items.delete_all
    @cart.update!(status: :converted, checked_out_at: Time.current)

    order

    rescue Product::OutOfStockError => e
      raise Error, e.message
    end
  end

  private
  
  def price_cart(cart)
    total = cart.cart_items.includes(:product)
                   .sum { |ci| ci.product.price * ci.quantity }
    
  end
end