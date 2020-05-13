class MenusController < ApplicationController
  def create
    name = params[:name]
    new_menu = Menu.new(name: name)
    if !new_menu.save
      flash[:error] = "Menu Name should not be Empty"
    end
    redirect_to create_menus_path
  end
end
