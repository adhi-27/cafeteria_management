class MenusController < ApplicationController
  def create
    name = params[:name]
    new_menu = Menu.new(name: name)
    if !new_menu.save
      flash[:error] = "Menu Name should not be Empty"
      redirect_to create_menus_path
    else
      session[:menu_id] = new_menu.id
      session[:menu_name] = name
      redirect_to "/cafeteria/menu_items"
    end
  end

  def destroy
    menu = Menu.find_by(id: params[:id])
    menu.specific_menu_items.destroy_all
    menu.destroy
    flash[:success] = "Menu destroyed Successfully"
    redirect_to "/cafeteria/menus"
  end
end
