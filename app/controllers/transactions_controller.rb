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

    amount_exceeds_balance = Transaction.amount_exceeds_balance(@transaction.amount,current_user)

    if amount_exceeds_balance
      flash[:alert] = "Amount exceeds your current balance. Please try again."
      render :withdraw_form
    else
      if current_user.kind_of?(User)
        @transaction.user_id = current_user.id
      end
      if @transaction.save
        redirect_to @transaction, notice: 'Withdrawal successful!'
      else
        render :withdraw_form
      end
    end

  end

  def create
    @transaction = Transaction.new(transaction_params)
    target_account_number = params[:transaction]['target_account_number']
    source_account = current_user
    target_account_exists = Transaction.account_exists?(target_account_number)
    @target_account = Transaction.find_account(target_account_number)
    amount_exceeds_balance = Transaction.amount_exceeds_balance(@transaction.amount,current_user)
    transferring_to_self = Transaction.transferring_to_self(current_user, @target_account)

    if amount_exceeds_balance
      flash[:alert] = "Amount exceeds your current balance. Please try again."
      render :new
    elsif target_account_exists && transferring_to_self
      flash[:alert] = "Transferring money to the same account is not allowed. Please enter a different account number."
      render :new
    else
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
