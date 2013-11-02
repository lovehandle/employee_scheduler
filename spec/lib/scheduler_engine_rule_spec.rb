require 'spec_helper'

require 'scheduler_engine_rule'
describe ConflictRule do
  describe " #filter! " do
    let(:schedule)                { Schedule.new }
    let(:shift_start_time_day_1)  { DateTime.new(2011,11,1,10) }
    let(:shift_end_time_day_1)    { DateTime.new(2011,11,1,20) }

    let(:shift_start_time_day_2)  { shift_start_time_day_1 + 1.day }
    let(:shift_end_time_day_2)    { shift_end_time_day_1 + 1.day }
    let(:employees)               {employee_arr = [] ; 2.times{ employee_arr << FactoryGirl.create(:employee)} ;  employee_arr }
    
    it " should filter employees by there conflicts " do
      shift = Shift.create(:start_time => shift_start_time_day_1, :end_time => shift_end_time_day_1)
      Conflict.create(:start_time => shift_start_time_day_1, :end_time => shift_start_time_day_1 + 1.hour, :employee_id => employees[1].id)
      
      conflict_rule = described_class.new
      available_employees = conflict_rule.filter!(employees, shift, schedule)
      
      available_employees.include?(employees[0]).should be_true
      available_employees.include?(employees[1]).should be_false

      shift = Shift.create(:start_time => shift_start_time_day_2, :end_time => shift_end_time_day_2)
      Conflict.create(:start_time => shift_start_time_day_2 + 1.hour, :end_time => shift_start_time_day_2 + 2.hours, :employee_id => employees[0].id)
      Conflict.create(:start_time => shift_end_time_day_2 + 1.hour, :end_time => shift_end_time_day_2 + 2.hours, :employee_id => employees[1].id)

      available_employees = conflict_rule.filter!(employees, shift, schedule)
      
      available_employees.include?(employees[0]).should be_false
      available_employees.include?(employees[1]).should be_true
    end
  end
end
