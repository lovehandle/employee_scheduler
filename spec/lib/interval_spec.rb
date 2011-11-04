require 'spec_helper'

describe EmployeeScheduler::Interval do

  let(:start_time_one) { DateTime.new }
  let(:end_time_one)   { start_time_one + 3.hours }

  let(:start_time_two) { start_time_one }
  let(:end_time_two)   { end_time_one   }

  let(:interval_one) { described_class.new(start_time_one, end_time_one) }
  let(:interval_two) { described_class.new(start_time_two, end_time_two) }

  describe "#overlaps?" do
    subject { interval_one.overlaps?(interval_two) }

    context "intervals have identical start_time and end_time" do
      it { should be_true }
    end

    context "interval includes start_time but not end_time" do
      let(:start_time_two) { start_time_one + 1.hour }
      let(:end_time_two)   { end_time_one + 1.hour   }

      it { should be_true }
    end

    context "interval includes end_time but not start_time" do
      let(:start_time_two) { start_time_one - 1.hour }
      let(:end_time_two)   { end_time_one - 1.hour   }

      it { should be_true }
    end

    context "interval includes start_time and end_time" do
      let(:start_time_two) { start_time_one + 1.hour }
      let(:end_time_two)   { end_time_one - 1.hour   }

      it { should be_true }
    end

    context "interval is included within start_time and end_time" do
      let(:start_time_two) { start_time_one - 1.hour }
      let(:end_time_two)   { end_time_one + 1.hour   }

      it { should be_true }
    end

    context "interval does not conflict with start_time or end_time" do
      let(:start_time_two) { end_time_one + 1.hour }
      let(:end_time_two)   { end_time_one + 2.hour }

      it { should be_false }
    end
  end

  describe ".overlaps?" do
    subject { described_class.overlaps?(interval_one, interval_two) }

    let(:overlaps) { true }

    before do
      interval_one.stub(:overlaps?).and_return(overlaps)
    end

    it { should be_true }

    context "interval_one#overlaps? returns false" do
      let(:overlaps) { false }

      it { should be_false }
    end
  end

end
