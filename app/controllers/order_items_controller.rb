class OrderItemsController < ApplicationController
  def create
    mitem_id = params[:menu_item_id]
    quantity = params[:quantity]
    @order_item = OrderItem.find_by(order_id: session[:current_order_id], menu_item_id: mitem_id)
    if @order_item
      @order_item.quantity = quantity
      @order_item.save!
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
    redirect_to "/"
  end
end
