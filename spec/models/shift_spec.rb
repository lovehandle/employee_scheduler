require 'spec_helper'

describe Shift do
  it {
    should validate_presence_of :start_time
    should validate_presence_of :end_time
    should validate_presence_of :date
  }
  
  describe '#start_time_numeric' do
    it "should return numeric value of start_time" do
      shift = FactoryGirl.create(:shift)
      shift.start_time_numeric.should be_a_kind_of(Float)
    end
  end
  
  describe '#end_time_numeric' do
    it "should return numeric value of end_time" do
      shift = FactoryGirl.create(:shift)
      shift.end_time_numeric.should be_a_kind_of(Float)
    end
  end
  
end
