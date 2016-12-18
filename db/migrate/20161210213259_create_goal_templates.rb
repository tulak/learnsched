class CreateGoalTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :goal_templates do |t|
      t.string :name
      t.boolean :public
      t.belongs_to :owner

      t.timestamps
    end
  end
end
