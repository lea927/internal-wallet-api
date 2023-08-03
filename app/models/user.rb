class User < ApplicationRecord
  has_many :transactions
  belongs_to :team
  has_and_belongs_to_many :stocks
end
