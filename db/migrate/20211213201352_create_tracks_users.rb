class CreateTracksUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks_users do |t|
      t.references :track, null: false
      t.references :user, null: false
      t.string :status, null: false
      t.boolean :finished, null: false ,default: false
      t.timestamps
    end
  end
end
