class TransactionsController < ApplicationController
  after_action :create_credit_transaction, only: [:create]
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
    source_account_number = params[:transaction]['source_account_number']
    account_exists = Transaction.account_exists?(source_account_number)
    source_account = Transaction.find_user_or_team(source_account_number)

    if account_exists
      @transaction.source_wallet_account_no = source_account_number
      @transaction.target_wallet_account_no = source_account_number

      if source_account.kind_of?(User)
        @transaction.user_id = source_account.id
      else
        @transaction.team_id = source_account.id
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
    source_account_number = params[:transaction]['source_account_number']

    account_exists = Transaction.account_exists?(target_account_number)
    source_account = Transaction.find_user_or_team(source_account_number)
    @target_account = Transaction.find_user_or_team(target_account_number)

    if account_exists
      @transaction.target_wallet_account_no = target_account_number
      @transaction.source_wallet_account_no = source_account_number
      @transaction.transaction_type = :debit
      if source_account.kind_of?(User)
        @transaction.user_id = source_account.id
      else
        @transaction.team_id = source_account.id
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
    else
      @transaction.team_id = @target_account.id
    end

    debit_transaction = Transaction.new({
                                          amount: @transaction.amount,
                                          target_wallet_account_no: @transaction.target_wallet_account_no,
                                          source_wallet_account_no: @transaction.source_wallet_account_no,
                                          transaction_type: :credit
                                        })

    if @target_account.kind_of?(User)
      debit_transaction.user_id = @transaction.user_id
    else
      debit_transaction.team_id = @transaction.team_id
    end

    unless debit_transaction.save
      Rails.logger.error("Failed to create corresponding debit transaction for Transaction ID: #{@transaction.id}")
    end
  end

  def transaction_params
    params.require(:transaction).permit(:amount)
  end
end
