class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "sessions/new"
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to "/"
    else
      flash[:error] = "Your Name or Password was Ivalid. Please retry."
      redirect_to new_sessions_path
    end
  end

  def delete
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to "/"
  end
end
