class AddTeamToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :team, null: false, foreign_key: true
  end
end
