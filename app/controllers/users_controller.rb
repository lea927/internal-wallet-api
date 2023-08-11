class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @balance = Transaction.calculate_balance_for(@user)
  end
end
