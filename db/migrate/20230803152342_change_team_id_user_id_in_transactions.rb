class ChangeTeamIdUserIdInTransactions < ActiveRecord::Migration[6.0]
  def change
    change_column_null :transactions, :team_id, true
    change_column_null :transactions, :user_id, true
  end
end
