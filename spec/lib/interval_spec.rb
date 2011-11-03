require 'spec_helper'

describe EmployeeScheduler::Interval do
  describe " #overlaps? " do
    it " should return true " do
      shift_one = Shift.create(:start_time => DateTime.new(2011,11,3,2,0), :end_time => DateTime.new(2011,11,3,4,0))
      shift_two = Shift.create(:start_time => DateTime.new(2011,11,3,3,30), :end_time => DateTime.new(2011,11,3,4,30))
      
      interval_one = EmployeeScheduler::Interval.create_interval_from_shift(shift_one)
      interval_two = EmployeeScheduler::Interval.create_interval_from_shift(shift_two)
      
      interval_one.overlaps?(interval_two).should be_true
      interval_two.overlaps?(interval_one).should be_true
      
      shift_two = Shift.create(:start_time => DateTime.new(2011,11,3,1,30), :end_time => DateTime.new(2011,11,3,2,30))
      interval_two = EmployeeScheduler::Interval.create_interval_from_shift(shift_two)
      
      interval_one.overlaps?(interval_two).should be_true
      interval_two.overlaps?(interval_one).should be_true
      
      shift_two = Shift.create(:start_time => DateTime.new(2011,11,3,2,30), :end_time => DateTime.new(2011,11,3,3,30))
      interval_two = EmployeeScheduler::Interval.create_interval_from_shift(shift_two)
      
      interval_one.overlaps?(interval_two).should be_true
      interval_two.overlaps?(interval_one).should be_true
      
      shift_two = Shift.create(:start_time => DateTime.new(2011,11,3,1,0), :end_time => DateTime.new(2011,11,3,5,0))
      interval_two = EmployeeScheduler::Interval.create_interval_from_shift(shift_two)
      
      interval_one.overlaps?(interval_two).should be_true
      interval_two.overlaps?(interval_one).should be_true
    end
    
    it " should return false " do
      shift_one = Shift.create(:start_time => DateTime.new(2011,11,3,2,0), :end_time => DateTime.new(2011,11,3,4,0))
      shift_two = Shift.create(:start_time => DateTime.new(2011,11,3,0,0), :end_time => DateTime.new(2011,11,3,2,0))
      
      interval_one = EmployeeScheduler::Interval.create_interval_from_shift(shift_one)
      interval_two = EmployeeScheduler::Interval.create_interval_from_shift(shift_two)
      
      interval_one.overlaps?(interval_two).should be_false
      interval_two.overlaps?(interval_one).should be_false
      
      shift_two = Shift.create(:start_time => DateTime.new(2011,11,3,0,0), :end_time => DateTime.new(2011,11,3,1,0))
      interval_two = EmployeeScheduler::Interval.create_interval_from_shift(shift_two)
      
      interval_one.overlaps?(interval_two).should be_false
      interval_two.overlaps?(interval_one).should be_false
      
      shift_two = Shift.create(:start_time => DateTime.new(2011,11,3,4,0), :end_time => DateTime.new(2011,11,3,5,0))
      interval_two = EmployeeScheduler::Interval.create_interval_from_shift(shift_two)
      
      interval_one.overlaps?(interval_two).should be_false
      interval_two.overlaps?(interval_one).should be_false
    end
  end
end
