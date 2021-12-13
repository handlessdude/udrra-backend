class CreateDetailsTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :details_tracks do |t|
      t.references :detail, null: false
      t.references :track, null: false
      t.boolean :finished, default: false
      t.boolean :assigned, default: false
      t.timestamps
    end
  end
end
