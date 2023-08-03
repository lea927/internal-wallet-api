class Team < ApplicationRecord
  has_many :users
  has_many :transactions
  has_and_belongs_to_many :stocks
end
