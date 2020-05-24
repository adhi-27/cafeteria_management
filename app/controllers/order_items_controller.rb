class OrderItemsController < ApplicationController
  def create
    mitem_id = params[:menu_item_id]
    quantity = params[:quantity]
    if !session[:current_order_id]
      new_order = Order.create!(user_id: @current_user.id, date: Date.today, status: "Being Created")
      session[:current_order_id] = new_order.id
    end
    @order_item = OrderItem.find_by(order_id: session[:current_order_id], menu_item_id: mitem_id)
    if @order_item
      if quantity == 0
        @order_item.destroy
      else
        @order_item.quantity = quantity
        @order_item.save!
      end
    else
      mitem = MenuItem.all.find(mitem_id)
      OrderItem.create!(
        order_id: session[:current_order_id],
        menu_item_id: mitem.id,
        menu_item_name: mitem.name,
        menu_item_price: mitem.price,
        quantity: quantity,
      )
    end
    redirect_to "/cafeteria?category=#{params[:category]}"
  end

  def update
    oitem_id = params[:id]
    order_item = OrderItem.find_by(id: oitem_id)
    if params[:symbol] == "0"
      if order_item.quantity == 1
        order_item.destroy
      else
        order_item.quantity = order_item.quantity - 1
      end
    else
      if order_item.quantity == 5
        flash[:error] = "Max 5 Nos. Per Order Item"
      else
        order_item.quantity = order_item.quantity + 1
      end
    end
    order_item.save
    redirect_to "/cafeteria/cart"
  end

  def destroy
    order_item = MenuItem.find_by(id: params[:id])
    order_item.destroy
    flash[:success] = "Order Item Removed"
    redirect_to "/cafeteria/cart"
  end
end
