class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username], password_digest: params[:password])

    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully!"
    else
      flash.now[:alert] = "Invalid username or password."
      render :new
    end
  end

  def destroy
  end
end
