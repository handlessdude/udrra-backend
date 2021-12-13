class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.datetime :duration, null: false
      t.timestamps
    end
  end
end
