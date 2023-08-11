class RemoveFieldsInStock < ActiveRecord::Migration[6.0]
  def change
    remove_column :stocks, :stock_name
    remove_column :stocks, :current_price
  end
end
