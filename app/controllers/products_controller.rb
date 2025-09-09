class ProductsController < ApplicationController
  def index
    @pagy, @products = pagy(Product.order(created_at: :desc), items: 12)

    respond_to do | format |
      format.html
      format.turbo_stream
    end

  end

  def search
    @products = Product.where("title LIKE ?", "%#{Product.sanitize_sql_like(params[:query])}%")
    render 'products/index'
  end

end
