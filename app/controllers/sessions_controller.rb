class SessionsController < ApplicationController
  def new
  end

  def create
    input_password = params[:password]
    user = User.find_by(username: params[:username])

    if user
      user_salt = user.salt
      user_hashed_password = user.password_digest

      hashed_input_password = Digest::SHA256.hexdigest(input_password + user_salt)

      if hashed_input_password == user_hashed_password
        session[:user_id] = user.id
        redirect_to root_path, notice: "Logged in successfully!"
      else
        flash.now[:alert] = "Invalid password."
        render :new
      end
    else
      flash.now[:alert] = "Invalid username"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You've been logged out successfully."
  end

  private
  def hide_navbar?
    action_name == "new"
  end
end
