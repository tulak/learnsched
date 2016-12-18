class CreateTaskSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :task_schedules do |t|
      t.belongs_to :task
      t.belongs_to :goal
      t.boolean :completed
      t.datetime :completed_at
      t.datetime :scheduled_at

      t.timestamps
    end
  end
end
