class ApplicationController < ActionController::Base
  include Pagy::Backend
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_cart

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :guest_cart, :cart_count


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def guest_cart
    session[:guest_cart] ||= {}
  end

  def cart_count
    if user_signed_in?
      @current_cart&.total_quantity.to_i
    else
      guest_cart.values.map(&:to_i).sum
    end
  end

  def set_current_cart
    if user_signed_in?
      @current_cart = current_user.cart || current_user.create_cart

      # Merge any guest cart items once, then clear them
      if session[:guest_cart].present?
        session[:guest_cart].each do |pid, qty|
          @current_cart.add_product(pid, qty)
        end
        session.delete(:guest_cart)
      end
    else
      # IMPORTANT: do NOT create a Cart row for guests
      @current_cart = nil
    end
  end
end
