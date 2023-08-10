class TransactionsController < ApplicationController
  after_action :create_debit_transaction, only: [:create]
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
  
  def create_debit_transaction
    return unless @transaction.persisted?

    debit_transaction = Transaction.new({
                                          amount: @transaction.amount,
                                          target_wallet_id: @transaction.source_wallet_id,
                                          source_wallet_id: @transaction.target_wallet_id,
                                          transaction_type: :debit
                                        })

    unless debit_transaction.save
      Rails.logger.error("Failed to create corresponding debit transaction for Transaction ID: #{@transaction.id}")
    end
  end

  def transaction_params
    params.require(:transaction).permit(:amount)
  end
end
