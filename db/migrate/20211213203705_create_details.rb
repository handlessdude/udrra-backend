class CreateDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :details do |t|
      t.string :detail_type, null: false
      t.string :entity_name, null: false
      t.string :entity_duration, null: false
      t.references :entity,
                   null: false, polymorphic: true
      t.timestamps
    end
  end
end
