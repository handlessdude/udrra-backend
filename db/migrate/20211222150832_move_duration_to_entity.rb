class MoveDurationToEntity < ActiveRecord::Migration[6.1]
  def change
    remove_column :details, :entity_duration
    remove_column :courses, :duration
    add_column :courses, :duration, :string
    add_column :events, :duration, :string
  end
end
