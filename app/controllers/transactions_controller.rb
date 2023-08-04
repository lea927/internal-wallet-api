class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def create
    @transaction = Transaction.new(transaction_params)
    target_account_number = params[:transaction]['target_account_number']
    source_account_number = params[:transaction]['source_account_number']

    target_account = Transaction.find_target_account(target_account_number)

    if target_account
      @transaction.target_wallet_id = target_account_number
      @transaction.source_wallet_id = source_account_number
      @transaction.transaction_type = :credit
      if @transaction.save
        redirect_to @transaction
      else
        render :new
      end
    else
      flash[:alert] = "Account number not found."
      render :new
    end


  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount)
  end
end
