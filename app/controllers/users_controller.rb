class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "users/new"
  end

  def create
    name = params[:name]
    pass = params[:password]
    new_user = User.new(name: name, password: pass, role: "customer")
    if !new_user.save
      flash[:error] = new_user.errors.full_messages.join(", ")
      redirect_to new_user_path
    else
      redirect_to "/"
    end
  end
end
