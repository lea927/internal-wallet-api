# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# db/seeds.rb

# create user
user = User.create!(
  username: 'user1',
  password_digest: 'p@ssword123',
)

# create team
team = Team.create!(
  team_name: 'team1',
  users: [user]
)

# create initial user transaction
user_transaction = Transaction.create!(
  amount: 10000,
  transaction_type: :credit,
  source_wallet_id: team.id,
  target_wallet_id: user.id,
)

# create initial team transaction
team_transaction = Transaction.create!(
  amount: 10000,
  transaction_type: :credit,
  source_wallet_id: user.id,
  target_wallet_id: team.id
)
