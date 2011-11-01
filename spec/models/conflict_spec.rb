require 'spec_helper'

describe Conflict do
  it {
    should belong_to :employee
    should validate_presence_of :start_time
    should validate_presence_of :end_time
    should validate_presence_of :date
  }
  
  describe '#start_time_numeric' do
    it "should return numeric value of start_time" do
      conflict = FactoryGirl.create(:conflict)
      conflict.start_time_numeric.should be_a_kind_of(Float)
    end
  end
  
  describe '#end_time_numeric' do
    it "should return numeric value of end_time" do
      conflict = FactoryGirl.create(:conflict)
      conflict.end_time_numeric.should be_a_kind_of(Float)
    end
  end
  
  describe "#lies_in_shift" do
    before(:each) do
      employee = FactoryGirl.create(:employee)
      @conflict = Conflict.create(:start_time => "01:45", :end_time => "4:30", :date => Date.today, :employee_id => employee.id)
    end
    
    it "should return true given that conflict lies in shift" do
      shift = Shift.create(:start_time => "00:45", :end_time => "2:30", :date => Date.today)
      @conflict.lies_in_shift(shift).should be_true
    end
    
    it "should return false given that conflict  doesn't lies in shift" do
      shift = Shift.create(:start_time => "00:45", :end_time => "1:30", :date => Date.today)
      @conflict.lies_in_shift(shift).should be_false
    end
  end
  
end
