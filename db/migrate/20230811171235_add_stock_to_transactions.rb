class AddStockToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :stock, foreign_key: true, null: true
  end
end
