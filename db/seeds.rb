require 'digest'

10.times do |i|
  username = "user#{i + 1}"
  account_number = rand(10**11..(10**12)-1).to_s
  salt = SecureRandom.hex
  hashed_password = Digest::SHA256.hexdigest("#{ENV['SEED_USER_PASSWORD']}#{salt}")
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
    password_digest: hashed_password,
    user_type: type,
    account_number: account_number,
    salt: salt
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
