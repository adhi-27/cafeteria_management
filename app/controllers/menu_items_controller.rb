class MenuItemsController < ApplicationController
  def create
    new_menu_item = MenuItem.new(menu_items_params)
    if !new_menu_item.save
      flash[:error] = new_menu_item.errors.full_messages.join(", ")
    else
      if params[:menu_id]
        SpecificMenuItem.create!(menu_id: params[:menu_id], menu_item_id: new_menu_item.id)
      end
      flash[:success] = "Menu Item Added Successfully"
    end
    session[:menu_id] = params[:menu_id]
    session[:menu_name] = Menu.find_by(id: params[:menu_id]).name
    redirect_to "/cafeteria/menu_items"
  end

  private def menu_items_params
    params.permit(:name, :category, :description, :price, :image)
  end

  def destroy
    menu_item = MenuItem.find_by(id: params[:id])
    menu_item.destroy
    flash[:success] = "Menu Item Destroyed"
    redirect_to "/cafeteria/menu_items"
  end
end
