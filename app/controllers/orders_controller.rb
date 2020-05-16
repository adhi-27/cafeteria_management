class OrdersController < ApplicationController
  def confirm
    Order.confirm(session[:current_order_id], @current_user.role, params[:total])
    if @current_user.role == "Customer"
      flash[:success] = "Order ID: #{session[:current_order_id]} Has Been Placed Successfully"
    else
      flash[:success] = "Ordered Successfully!"
    end
    session[:current_order_id] = nil
    redirect_to "/"
  end

  def update
    order = Order.find_by(id: params[:id])
    order.status = "Delivered"
    order.delivered_at = DateTime.now
    order.save!
    flash[:success] = "Order ID: #{params[:id]} Delivered"
    redirect_to "/cafeteria/orders"
  end
end
