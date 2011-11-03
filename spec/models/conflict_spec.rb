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
    let(:shift_interval)    { mock(EmployeeScheduler::Interval) }
    let(:shift)             { mock(Shift, :to_interval => shift_interval) }

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
    it "returns an Interval instance" do
      subject.to_interval.should be_a(EmployeeScheduler::Interval)
    end
  end

end
