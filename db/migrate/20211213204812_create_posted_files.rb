class CreatePostedFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :posted_files do |t|
      t.string :type, null: false
      t.string :url, null: false
      t.timestamps
    end
  end
end
