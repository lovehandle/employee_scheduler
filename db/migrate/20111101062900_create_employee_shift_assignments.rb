class CreateEmployeeShiftAssignments < ActiveRecord::Migration
  def change
    create_table :employee_shift_assignments do |t|
      t.integer :employee_id
      t.integer :shift_id

      t.timestamps
    end
  end
end
