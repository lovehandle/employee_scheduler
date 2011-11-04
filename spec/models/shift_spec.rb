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

    let(:start_time) { DateTime.new }
    let(:end_time)   { start_time + 3.hours }

    before do
      subject.stub(:start_time).and_return(start_time)
      subject.stub(:end_time).and_return(end_time)
    end

    it "initializes a new Interval" do
      EmployeeScheduler::Interval.should_receive(:new).with(start_time, end_time)
      subject.to_interval
    end

    it "returns an instance of EmployeeScheduler::Interval" do
      subject.to_interval.should be_a(EmployeeScheduler::Interval)
    end
  end
end
