class ChangeAndRenameWalletFields < ActiveRecord::Migration[6.0]
  def up
    change_column :transactions, :source_wallet_id, :string
    change_column :transactions, :target_wallet_id, :string

    rename_column :transactions, :source_wallet_id, :source_wallet_account_no
    rename_column :transactions, :target_wallet_id, :target_wallet_account_no
  end

  def down
    change_column :transactions, :source_wallet_id, :integer
    change_column :transactions, :target_wallet_id, :integer

    rename_column :transactions, :source_wallet_account_no, :source_wallet_id
    rename_column :transactions, :target_wallet_account_no, :target_wallet_id
  end
end
