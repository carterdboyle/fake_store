class ProductsController < ApplicationController
  def index
    @pagy, @products = pagy(Product.order(created_at: :desc), items: 8)

    respond_to do | format |
      format.html
      format.turbo_stream do
        sleep 2
        #sleep 20 -- uncomment for testing
        #render 'index'
      end
    end

  end

  def search
    @products = Product.where("title LIKE ?", "%#{Product.sanitize_sql_like(params[:query])}%")
    render 'products/index'
  end

  def update
    return unless current_user.is_admin?
    @product = Product.find(params[:id])
    @product.increment!(:amount, params[:quantity].to_i)
    flash.now[:notice] = "Stock added!"
  end

end
