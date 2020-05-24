class CafeteriaController < ApplicationController
  def index
    @menu = Menu.active_menu
    render "index"
  end

  def about
    render "/cafeteria/about"
  end

  def menus
    if @current_user.role == "owner"
      @menu = params[:menu_id] ? Menu.find_by(id: params[:menu_id]) : Menu.find_by(active: true)
      render "/cafeteria/menus"
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
      @user_orders = @current_user.orders.placed?
    else
      if params[:order] == "D"
        @user_orders = Order.where(:status => "Delivered")
      else
        @user_orders = Order.where(:status => "Confirmed")
      end
    end
    render "orders"
  end

  def menu_items
    if @current_user.role == "owner"
      @menu_items = MenuItem.all
      if session[:menu_id]
        @menu_id = session[:menu_id]
        session[:menu_id] = nil
      end
      if session[:menu_name]
        @title = session[:menu_name]
        session[:menu_name] = nil
      else
        @title = "Menu Items"
      end
      render "/cafeteria/menu_items"
    else
      redirect_to cafeteria_path
    end
  end

  def add_item
    session[:menu_id] = params[:id]
    session[:menu_name] = params[:name]
    redirect_to "/cafeteria/menu_items"
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

  def report
    if @current_user.role == "owner"
      if params[:from_date]
        from = params[:from_date]
      else
        from = Order.first.date
      end
      @orders = Order.where("date >= ? and status = ?", from, "Delivered")
      if params[:to_date] !=
         to = params[:to_date]
      else
        to = Order.last.date
      end
      @range = "Report from #{from} to #{to}"
      @orders = @orders.where("date <= ? ", to)
      @count = @orders.count
      @total = @orders.total
      render "/cafeteria/sales_report"
    else
      redirect_to cafeteria_path
    end
  end
end
