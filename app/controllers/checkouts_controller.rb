class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    cart = current_user.cart || Cart.create!(user: current_user)
    if cart.cart_items.exists?
      order = CheckoutCart.new(cart: cart, user: current_user).call
      redirect_to order_path(order.public_id), notice: "Order placed!"
    else
      redirect_back fallback_location: root_path, alert: "Your cart is empty."
    end
  end
end