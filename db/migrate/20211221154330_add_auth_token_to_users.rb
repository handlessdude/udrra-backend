class AddAuthTokenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :auth_token, :string
    add_index :users, :auth_token
    add_column :users, :auth_token_date, :datetime
  end
end
