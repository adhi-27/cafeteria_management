class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      session[:current_order_id] = nil
    else
      flash[:error] = "Your Email or Password was Invalid."
    end
    redirect_to "/"
  end

  def delete
    session[:current_user_id] = nil
    if session[:current_order_id]
      order = Order.find_by(id: session[:current_order_id])
      order.order_items.destroy_all
      order.destroy
    end
    @current_user = nil
    redirect_to "/"
  end
end
