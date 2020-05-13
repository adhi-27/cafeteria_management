class MenuItemsController < ApplicationController
  def create
    name = params[:name]
    menu_id = params[:menu_id]
    price = params[:price]
    new_menu_item = MenuItem.new(name: name, menu_id: menu_id, price: price)
    if !new_menu_item.save
      flash[:error] = new_menu_item.errors.full_messages.join(", ")
    end
    redirect_to create_menus_path
  end
end
