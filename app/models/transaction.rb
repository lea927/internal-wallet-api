class Transaction < ApplicationRecord
  attr_accessor :target_account_number, :source_account_number

  belongs_to :user, optional: true
  belongs_to :team, optional: true

  enum transaction_type: { credit: 0, debit: 1 }

  def self.account_exists?(account_number)
    result = false
    user = User.where(account_number: account_number).first
    if user.present?
      result = true
    end

    team = Team.where(account_number: account_number).first
    if team.present?
      result = true
    end

    result
  end

  def self.find_user_or_team(account_number)
    user = User.where(account_number: account_number).first
    if user.present?
      account = user
    end

    team = Team.where(account_number: account_number).first
    if team.present?
      account = team
    end

    account
  end
end
