class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(placed_at: :desc)
  end

  def show
    @order = current_user.orders.find_by!(public_id: params[:public_id])
  end
end