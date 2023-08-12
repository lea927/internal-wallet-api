class DropTeamAndStock < ActiveRecord::Migration[6.0]
  def change
    drop_table :teams
    drop_table :stocks
  end
end
