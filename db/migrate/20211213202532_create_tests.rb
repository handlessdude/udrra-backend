class CreateTests < ActiveRecord::Migration[6.1]
  def change
    create_table :tests do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.text :instruction, null: false
      t.string :duration, null: false
      t.string :img, null: false
      t.timestamps
    end
  end
end
