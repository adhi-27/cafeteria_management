class SpecificMenuItemsController < ApplicationController
  def create
    if params[:contains] == "0"
      sitem = SpecificMenuItem.find_by(menu_id: params[:menu_id], menu_item_id: params[:mitem_id])
      sitem.destroy
    else
      SpecificMenuItem.create!(menu_id: params[:menu_id], menu_item_id: params[:mitem_id])
    end
    redirect_to "/cafeteria/menu_items"
  end

  def destroy
    specific_menu_item = SpecificMenuItem.find_by(id: params[:id])
    name = Menu.find_by(id: specific_menu_item.menu_id).name
    specific_menu_item.destroy
    flash[:success] = "#{name} Item Destroyed"
    redirect_to "/cafeteria/menus"
  end
end
