class User < ApplicationRecord
  has_many :transactions

  enum user_type: { user: 0, team: 1, stock: 2 }

  def to_param
    username
  end
end
