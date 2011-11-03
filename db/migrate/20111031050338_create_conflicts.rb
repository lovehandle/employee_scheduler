class CreateConflicts < ActiveRecord::Migration
  def change
    create_table :conflicts do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :employee_id

      t.timestamps
    end
  end
end
