class User < ApplicationRecord
  has_many :transactions

  enum user_type: { user: 0, team: 1, stock: 2 }


  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false, message: "is already taken" },
            length: { minimum: 3, maximum: 50, message: "should be between 3 to 50 characters" },
            format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only allows letters, numbers, and underscores" }

  validates :account_number,
            presence: { message: "is required" },
            uniqueness: { case_sensitive: false, message: "has already been taken" },
            length: { is: 12, message: "must be 12 digits long" },
            format: { with: /\A[0-9]+\z/, message: "only allows numbers" }

  def to_param
    username
  end
end
