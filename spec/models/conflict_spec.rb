require 'spec_helper'

describe Conflict do
  it {
    should belong_to :employee
    should validate_presence_of :start_time
    should validate_presence_of :end_time
  }
  
  describe "#lies_in_shift?" do
    before(:each) do
      employee = FactoryGirl.create(:employee)
      @conflict = Conflict.create(:start_time => DateTime.new(2011,11,3,1,45), :end_time => DateTime.new(2011,11,3,4,30), :employee_id => employee.id)
    end
    
    it "should return true given that conflict lies in shift" do
      shift = Shift.create(:start_time => DateTime.new(2011,11,3,0,45), :end_time => DateTime.new(2011,11,3,2,30))
      @conflict.lies_in_shift?(shift).should be_true
    end
    
    it "should return false given that conflict  doesn't lies in shift" do
      shift = Shift.create(:start_time => DateTime.new(2011,11,3,0,45), :end_time => DateTime.new(2011,11,3,1,30))
      @conflict.lies_in_shift?(shift).should be_false
    end
  end
  
end
