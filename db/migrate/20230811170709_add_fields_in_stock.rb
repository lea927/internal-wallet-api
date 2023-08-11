class AddFieldsInStock < ActiveRecord::Migration[6.0]
  def change
    add_column :stocks, :username, :string
    add_column :stocks, :password_digest, :string
    add_column :stocks, :account_number, :string
  end
end
