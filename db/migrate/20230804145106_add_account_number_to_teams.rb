class AddAccountNumberToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :account_number, :string
  end
end
