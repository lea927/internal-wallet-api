class Transaction < ApplicationRecord
  attr_accessor :target_account_number, :source_account_number

  belongs_to :user, optional: true
  belongs_to :team, optional: true

  enum transaction_type: { credit: 0, debit: 1 }

  def self.account_exists?(account_number)
    return true if User.find_by(account_number: account_number).present?
    return true if Team.find_by(account_number: account_number).present?
    return true if Stock.find_by(account_number: account_number).present?

    false
  end

  def self.find_account(account_number)
    user = User.find_by(account_number: account_number)
    return user if user.present?

    team = Team.find_by(account_number: account_number)
    return team if team.present?

    stock = Stock.find_by(account_number: account_number)
    return stock if stock.present?

    nil
  end

  def self.calculate_balance_for(user)
    credit_amount = where(user: user, transaction_type: :credit).sum(:amount)
    debit_amount = where(user: user, transaction_type: :debit).sum(:amount)

    credit_amount - debit_amount
  end
end
