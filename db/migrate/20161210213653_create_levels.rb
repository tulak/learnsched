class CreateLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :levels do |t|
      t.string :name
      t.belongs_to :goal_template

      t.timestamps
    end
  end
end
