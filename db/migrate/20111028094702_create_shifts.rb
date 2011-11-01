class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.string :start_time
      t.string :end_time
      t.date :date
      
      t.timestamps
    end
  end
end
