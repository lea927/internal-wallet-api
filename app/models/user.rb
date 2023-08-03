class User < ApplicationRecord
  has_many :transactions
  belongs_to :team, optional: true
  has_and_belongs_to_many :stocks
end
