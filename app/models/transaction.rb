class Transaction < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :team, optional: true

  enum transaction_type: { credit: 0, debit: 1 }
end
