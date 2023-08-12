# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# db/seeds.rb

10.times do |i|
  username = "user#{i + 1}"
  account_number = rand(10000..99999).to_s
  type =
    if i < 3
      :user
    elsif i < 6
      :team
    else
      :stock
    end

  user = User.create!(
    username: username,
    password_digest: ENV['SEED_USER_PASSWORD'],
    user_type: type,
    account_number: account_number
  )

  Transaction.create!(
    amount: 10000,
    transaction_type: :credit,
    source_wallet_account_no: '',
    target_wallet_account_no: user.account_number,
    user_id: user.id,
    )

  Transaction.create!(
    amount: 100,
    transaction_type: :debit,
    source_wallet_account_no: '',
    target_wallet_account_no: user.account_number,
    user_id: user.id,
    )
end
