require 'spec_helper'

describe Schedule do
  let(:schedule)  { described_class.new }
  let(:date)      { Date.today }
  let(:shift)     { mock(Shift, :start_time => DateTime.new(2011,11,2,10), :end_time => DateTime.new(2011,11,2,20), :date => Date.new(2011,11,2)) }
  let(:employees) { [mock(Employee) ,mock(Employee)]}
  
  describe " #add_date_to_schedule " do
    it " should create an empty hash " do
      schedule.schedule.should be_blank
      schedule.add_date_to_schedule(date)

      schedule.schedule.should_not be_blank
      schedule.schedule[date].should be_blank
      schedule.schedule[date].is_a?(Hash).should be_true
    end
  end

  describe " #add_shift_for_date " do
    it " should create an empty array " do
      schedule.schedule.should be_blank
      schedule.add_shift_for_date(shift, date)

      schedule.schedule.should_not be_blank
      schedule.schedule[date].should_not be_blank
      schedule.schedule[date][shift].should be_blank
      schedule.schedule[date][shift].is_a?(Array).should be_true
    end

    it " should not overwrite array " do
      schedule.schedule.should be_blank      
      schedule.add_shift_for_date(shift, date)

      schedule.schedule[date].should_not be_blank
      schedule.schedule[date][shift].should be_blank
      
      schedule.schedule[date][shift] << shift
      
      schedule.schedule[date][shift].should_not be_blank
      schedule.add_shift_for_date(shift, date)
      schedule.schedule[date][shift].should_not be_blank
    end
  end
  
  describe " #add_employees_to_shift " do
    it " should assign employee to shift " do
      schedule.schedule.should be_blank
      schedule.employee_schedule.should be_blank
      schedule.add_employees_to_shift(employees, shift)
      
      schedule.schedule.should_not be_blank
      schedule.schedule[shift.date].should_not be_blank
      schedule.schedule[shift.date][shift].should_not be_blank
      schedule.employee_schedule.should_not be_blank
      
      employees.each do |employee|
        schedule.schedule[shift.date][shift].include?(employee).should be_true
        schedule.employee_schedule[employee].include?(shift).should be_true
      end
    end
  end
  
  describe " #get_employees_for_shift " do
    it " should return employee for shift " do
      schedule.add_employees_to_shift(employees, shift)
      shift_employees = schedule.get_employees_for_shift(shift)
      
      employees.each do |employee|
          shift_employees.include?(employee).should be_true
      end
      new_shift = mock(Shift, :start_time => DateTime.new(2011,11,3,10), :end_time => DateTime.new(2011,11,3,20), :date => Date.new(2011,11,3))
      schedule.get_employees_for_shift(new_shift).should be_nil
    end
  end
  
  describe " #get_employee_shifts " do
    it " should return shifts for employee " do
      schedule.add_employees_to_shift(employees, shift)
      employees.each do |employee|
        schedule.get_employee_shifts(employee).include?(shift).should be_true
      end
      employee  = mock(Employee)
      schedule.get_employee_shifts(employee).should be_nil
    end
  end
end
