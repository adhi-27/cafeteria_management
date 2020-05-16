class CafeteriaController < ApplicationController
  def index
    @menu = Menu.active_menu
    render "index"
  end

  def menus
    if @current_user.role == "owner"
      render "menus"
    else
      redirect_to cafeteria_path
    end
  end

  def users
    if @current_user.role == "owner"
      @users = User.all
      render "users"
    else
      redirect_to cafeteria_path
    end
  end

  def orders
    if @current_user.role == "Customer"
      @user_orders = @current_user.orders
    else
      @user_orders = Order.all
    end
    render "orders"
  end

  def activate
    menu_id = (params[:menu_id]).to_i
    Menu.all.each do |menu|
      menu.active = menu.id != menu_id ? false : true
      menu.save!
    end
    flash[:success] = "Menu was Activated Successfully"
    redirect_to create_menus_path
  end

  def cart
    current_order = Order.find_by(id: session[:current_order_id])
    if current_order
      @order_items = current_order.order_items
    else
      @order_items = nil
    end
    render "cart"
  end
end
