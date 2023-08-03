class ChangeWalletIdsNotNullInTransactions < ActiveRecord::Migration[6.0]
  def change
    change_column_null :transactions, :source_wallet_id, false
    change_column_null :transactions, :target_wallet_id, false
  end
end
