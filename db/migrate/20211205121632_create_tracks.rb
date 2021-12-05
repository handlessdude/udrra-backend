class CreateTracks < ActiveRecord::Migration[6.1]
  def up
    create_table :tracks do |t|
      t.string :track_name, null: false
      t.text :preview_text, null: false
      t.string :preview_picture, null: false
      t.boolean :published, null: false
      t.string :mode, null: false

      t.timestamps
    end
  end

  def down
    drop_table :tracks
  end
end
