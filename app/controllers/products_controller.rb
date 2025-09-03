class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def search
    @products = Product.where("title LIKE ?", "%#{Product.sanitize_sql_like(params[:query])}%")
    render 'products/index'
  end

end
