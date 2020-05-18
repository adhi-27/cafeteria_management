class MenuItemsController < ApplicationController
  def create
    name = params[:name]
    category = params[:category]
    menu_id = params[:menu_id]
    price = params[:price]
    new_menu_item = MenuItem.new(name: name, category: category, menu_id: menu_id, price: price)
    if !new_menu_item.save
      flash[:error] = new_menu_item.errors.full_messages.join(", ")
    else
      flash[:success] = "Menu Item Added Successfully"
    end
    redirect_to create_menus_path
  end

  def destroy
    menu_item = MenuItem.find_by(id: params[:id])
    menu_item.destroy
    flash[:success] = "Menu Item Destroyed"
    redirect_to "/cafeteria/menus"
  end
end
