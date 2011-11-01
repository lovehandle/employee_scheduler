class CreateConflicts < ActiveRecord::Migration
  def change
    create_table :conflicts do |t|
      t.date :date
      t.string :start_time
      t.string :end_time
      t.integer :employee_id

      t.timestamps
    end
  end
end
