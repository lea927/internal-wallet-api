class UsersController < ApplicationController
  def show
    @user = User.find_by!(username: params[:id])
    @balance = Transaction.calculate_balance_for(@user)
  end
end
