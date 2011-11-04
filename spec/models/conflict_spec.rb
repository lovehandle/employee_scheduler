require 'spec_helper'

describe Conflict do
  it {
    should belong_to :employee
    should validate_presence_of :start_time
    should validate_presence_of :end_time
  }

  describe "#lies_in_shift?" do
    let(:overlaps) { true }

    let(:conflict_interval) { mock(EmployeeScheduler::Interval, :overlaps? => overlaps) }
    let(:shift)             { Shift.new }

    before do
      subject.stub(:to_interval).and_return(conflict_interval)
    end

    context "intervals overlap" do
      it { subject.lies_in_shift?(shift).should be_true }
    end

    context "intervals do not overlap" do
      let(:overlaps) { false }
      it { subject.lies_in_shift?(shift).should be_false }
    end
  end

  describe "#to_interval" do

    let(:start_time) { DateTime.new }
    let(:end_time)   { start_time + 3.hours }

    before do
      subject.stub(:start_time).and_return(start_time)
      subject.stub(:start_time).and_return(start_time)
    end

    it "initializes a new Interval" do
      EmployeeScheduler::Interval.should_receive(:new).with(start_time, end_time)
      subject.to_interval
    end

    it "returns an Interval instance" do
      subject.to_interval.should be_a(EmployeeScheduler::Interval)
    end
  end

end
