class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.belongs_to :level
      t.string :name
      t.string :description
      t.string :resources
      t.integer :estimated_time

      t.timestamps
    end
  end
end
