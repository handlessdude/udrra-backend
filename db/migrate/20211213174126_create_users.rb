class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.string :encrypted_password, null: false
      t.string :first_name, null: false
      t.string :second_name, null: false
      t.string :avatar_url

      t.timestamps
    end
  end
end
