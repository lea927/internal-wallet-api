class Stock < ApplicationRecord
  has_many :transactions
  has_and_belongs_to_many :users
  has_and_belongs_to_many :teams
end
