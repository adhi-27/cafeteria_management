class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      new_order = Order.create!(user_id: user.id, date: Date.today, status: "Being Created")
      session[:current_order_id] = new_order.id
    else
      flash[:error] = "Your Name or Password was Ivalid. Please retry."
    end
    redirect_to "/"
  end

  def delete
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to "/"
  end
end
