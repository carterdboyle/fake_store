class CartsController < ApplicationController
  def show
    if user_signed_in?
      @cart = @current_cart
    else
      ids = guest_cart.keys.map(&:to_i)
      @guest_products = Product.where(id: ids).index_by(&:id)
    end
  end

  def destroy
    if user_signed_in?
      @current_cart.destroy
    else
      guest_cart.clear
    end

    redirect_to cart_path, notice: "Cart deleted!"
  end
end
