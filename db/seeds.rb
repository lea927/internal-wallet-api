# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# db/seeds.rb

user = User.create!(
  username: 'user1',
  password_digest: 'p@ssword123',
  account_number: '12345'
)

user_credit_transaction = Transaction.create!(
  amount: 10000,
  transaction_type: :credit,
  source_wallet_account_no: '67890',
  target_wallet_account_no: '12345',
  user_id: user.id,
)

user_debit_transaction = Transaction.create!(
  amount: 100,
  transaction_type: :debit,
  source_wallet_account_no: '67890',
  target_wallet_account_no: '12345',
  user_id: user.id,
)
