class TransactionsController < ApplicationController
  after_action :create_credit_transaction, only: [:create]
  before_action :authenticate_user!, only: [:new, :withdraw_form]
  def new
    @transaction = Transaction.new
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def withdraw_form
    @transaction = Transaction.new
  end

  def withdraw
    @transaction = Transaction.new(transaction_params)
    @transaction.transaction_type = :debit
    @transaction.source_wallet_account_no = current_user.account_number
    @transaction.target_wallet_account_no = current_user.account_number

    if current_user.kind_of?(User)
      @transaction.user_id = current_user.id
    end
    if @transaction.save
      redirect_to @transaction, notice: 'Withdrawal successful!'
    else
      render :withdraw_form
    end
  end

  def create
    @transaction = Transaction.new(transaction_params)
    target_account_number = params[:transaction]['target_account_number']
    source_account = current_user
    target_account_exists = Transaction.account_exists?(target_account_number)
    @target_account = Transaction.find_account(target_account_number)

    if target_account_exists
      @transaction.target_wallet_account_no = target_account_number
      @transaction.source_wallet_account_no = source_account.account_number
      @transaction.transaction_type = :debit
      if source_account.kind_of?(User)
        @transaction.user_id = source_account.id
      end
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

  def create_credit_transaction
    return unless @transaction.persisted?

    if @target_account.kind_of?(User)
      @transaction.user_id = @target_account.id
    end

    credit_transaction = Transaction.new({
                                          amount: @transaction.amount,
                                          target_wallet_account_no: @transaction.target_wallet_account_no,
                                          source_wallet_account_no: @transaction.source_wallet_account_no,
                                          transaction_type: :credit
                                        })

    if @target_account.kind_of?(User)
      credit_transaction.user_id = @transaction.user_id
    end

    unless credit_transaction.save
      Rails.logger.error("Failed to create corresponding credit transaction for Transaction ID: #{@transaction.id}")
    end
  end

  def transaction_params
    params.require(:transaction).permit(:amount)
  end
end
