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

team = Team.create!(
  team_name: 'team1',
  users: [user],
  account_number: '67890'
)

stock = Stock.create!(
  username: 'stock1',
  password_digest: 'p@ssword123',
  account_number: '01234'
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

team_credit_transaction = Transaction.create!(
  amount: 10000,
  transaction_type: :credit,
  source_wallet_account_no: '12345',
  target_wallet_account_no: '67890',
  team_id: team.id,
)

team_debit_transaction = Transaction.create!(
  amount: 100,
  transaction_type: :debit,
  source_wallet_account_no: '12345',
  target_wallet_account_no: '67890',
  team_id: team.id,
)

stock_credit_transaction = Transaction.create!(
  amount: 10000,
  transaction_type: :credit,
  source_wallet_account_no: '12345',
  target_wallet_account_no: '01234',
  stock_id: stock.id,
)

stock_debit_transaction = Transaction.create!(
  amount: 100,
  transaction_type: :debit,
  source_wallet_account_no: '12345',
  target_wallet_account_no: '01234',
  stock_id: stock.id,
)
