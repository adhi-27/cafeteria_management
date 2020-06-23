class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "users/new"
  end

  def create
    name = params[:name]
    pass = params[:password]
    mail = params[:email]
    repass = params[:repass]
    if mail != ""
      user = User.find_by(email: mail)
      if user
        flash[:error] = "Email already Registered"
        redirect_to "/users/new"
        return
      end
    end
    if pass != ""
      if repass != pass
        flash[:error] = "Password does not match"
        redirect_to "/users/new"
        return
      end
    end
    new_user = User.new(name: name, email: mail, password: pass, role: "Customer")
    if !new_user.save
      flash[:error] = new_user.errors.full_messages.join(", ")
      redirect_to new_user_path
    else
      session[:current_user_id] = new_user.id
      session[:current_order_id] = nil
      redirect_to "/"
    end
  end

  def update
    user = User.find_by(id: params[:id])
    if user.role == "Customer"
      user.role = "Billing Clerk"
    else
      user.role = "Customer"
    end
    user.save!
    flash[:success] = "User Is Now A #{user.role}"
    redirect_to "/cafeteria/users"
  end
end
