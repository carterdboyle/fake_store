class CartItemsController < ApplicationController
  before_action :set_guest_maxes, only: [:create, :update]

  def create
    product = Product.find(params[:product_id])
    max = [99, product.amount.to_i].compact.min
    qty = params[:quantity].to_i.clamp(1, max)

    if user_signed_in?
      @current_cart.add_product(product.id, qty)
    else
      key = product.id.to_s
      # accumulate in session; clamp to stock/99
      guest_cart[key] = [guest_cart[key].to_i + qty, max].min
    end

    respond_to do | format |
      format.turbo_stream do
        # Show the flash immediately without a full-page visit
        flash.now[:notice] = "Added to cart."
        # Rails will render app/views/cart_items/create.turbo_stream.erb
      end
      format.html do
        redirect_back fallback_location: cart_path, notice: "Added to cart."
      end
    end
  end


  # PATCH /cart_items/:id
  # For guests, :id is the product_id in the URL (see forms below).
  def update
    if user_signed_in?
      item = @current_cart.cart_items.find(params[:id])
      max = [99, item.product.amount.to_i].compact.min
      new_qty = params.require(:cart_item)[:quantity].to_i.clamp(1, max)
      item.update!(quantity: new_qty)
    else
      product = Product.find(params[:id])
      max = [99, product.amount.to_i].compact.min
      new_qty = params.require(:cart_item)[:quantity].to_i.clamp(1, max)
      guest_cart[product.id.to_s] = new_qty
    end

    redirect_to cart_path, notice: "Quantity updated."
  end

  # DELETE /cart_items/:id
  # For guests, :id is the product_id to remove.
  def destroy
    if user_signed_in?
      item = @current_cart.cart_items.find(params[:id])
      item.destroy
    else
      guest_cart.delete(params[:id].to_s)
    end

    redirect_to cart_path, notice: "Item removed."
  end

  private
   # not strictly required; here to make intent clear
  def set_guest_maxes
    session[:guest_cart] ||= {}
  end
end