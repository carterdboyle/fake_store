class CartItemsController < ApplicationController
  before_action :load_cart
  def create
    product = Product.find(params[:product_id])
    qty = params[:quantity].presence || 1
    @cart.add_product(product.id, qty)
    redirect_back fallback_location: cart_path, notice: "Added to cart."
  end

  def update
    item = @cart.cart_items.find(params[:id])
    new_qty = params.require(:cart_item)[:quantity].to_i
    if new_qty > 0
      item.update!(quantity: [new_qty, 99].min)
      redirect_to cart_path, notice: "Quantity updated."
    else
      item.destroy
      redirect_to cart_path, notice: "Item removed."
    end
  end

  def destroy
    item = @cart.cart_items.find(params[:id])
    item.destroy
    redirect_to cart_path, notice: "Item removed."
  end

  private
  def load_cart
    @cart = @current_cart
  end
end