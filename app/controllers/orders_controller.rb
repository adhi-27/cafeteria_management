class OrdersController < ApplicationController
  def confirm
    Order.confirm(session[:current_order_id])
    flash[:success] = "Order ID: #{session[:current_order_id]} Has Been Placed Successfully"
    session[:current_order_id] = nil
    redirect_to "/"
  end

  def update
    order = Order.find_by(id: params[:id])
    order.status = "Delivered"
    order.delivered_at = DateTime.now
    order.save
    flash[:success] = "Order ID: #{params[:id]} Deliverd"
    redirect_to "/cafeteria/orders"
  end
end
