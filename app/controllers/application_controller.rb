class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_cart

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private
  def set_current_cart
    if user_signed_in?
      # Ensure user has a cart
      @current_cart = current_user.cart || current_user.create_cart
      # If there is a guest cart merge it into the session cart
      # But only once
      if session[:cart_id].present?
        begin
          guest_cart = Cart.find_by(id: session[:cart_id])
          if guest_cart && guest_cart.user_id.null? && guest_cart != @current_cart
            @current_cart.absorb!(guest_cart)
          end
        ensure
          session.delete(:cart_id)
        end
      end
    else
      # Guest cart lives in session
      @current_cart = Cart.find_by(id: session[:cart_id])
      unless @current_cart
        @current_cart = Cart.create! #no user_id
        session[:cart_id] = @current_cart.id
      end
    end
  end
end
