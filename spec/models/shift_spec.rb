require 'spec_helper'

describe Shift do
  it {
    should validate_presence_of :start_time
    should validate_presence_of :end_time
  }

  describe "#num_of_employees_needed" do
    it { subject.num_employees_needed.should eql(1) }
  end

  describe "#to_interval" do
    it "returns an instance of EmployeeScheduler::Interval" do
      subject.to_interval.should be_a(EmployeeScheduler::Interval)
    end
  end
end
