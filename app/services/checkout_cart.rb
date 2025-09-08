class CheckoutCart
  def initialize(cart:, user:)
    @cart = cart
    @user = user
  end

  def call
    ApplicationRecord.transaction do 
      total = price_cart(@cart)

      order = Order.create!(
        user: @user,
        total: total,
        placed_at: Time.current
      )

      @cart.cart_items.includes(:product).find_each do |ci|
        unit = ci.product.price
        OrderItem.create!(
          order: order,
          product: ci.product,
          product_name: ci.product.title,
          unit_price: unit,
          quantity: ci.quantity,
          total: unit * ci.quantity
        )
      end

      @cart.update!(status: :converted, checked_out_at: Time.current)
      @cart.cart_items.delete_all
      order
    end
  end

  private
  
  def price_cart(cart)
    total = cart.cart_items.includes(:product)
                   .sum { |ci| ci.product.price * ci.quantity }
    
  end
end