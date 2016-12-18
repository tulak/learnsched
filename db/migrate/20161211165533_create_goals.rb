class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.belongs_to :user
      t.belongs_to :goal_template

      t.timestamps
    end
  end
end
