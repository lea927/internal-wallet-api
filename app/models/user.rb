class User < ApplicationRecord
  has_many :transactions
  belongs_to :team
end
