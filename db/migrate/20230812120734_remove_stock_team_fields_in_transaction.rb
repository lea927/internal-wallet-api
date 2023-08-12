class RemoveStockTeamFieldsInTransaction < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :stock_id
    remove_column :transactions, :team_id
  end
end
