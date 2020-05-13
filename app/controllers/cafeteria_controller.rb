class CafeteriaController < ApplicationController
  def index
    @menu = Menu.active_menu
    render "cafeteria/index"
  end

  def menus
    render "cafeteria/menus"
  end

  def activate
    menu_id = (params[:menu_id]).to_i
    Menu.all.each do |menu|
      menu.active = menu.id != menu_id ? false : true
      menu.save!
    end
    redirect_to create_menus_path
  end
end
