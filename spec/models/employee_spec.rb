require 'spec_helper'

describe Employee do
  it {
    should validate_presence_of :email
  }
  
  describe '#get_conflicts_on' do
    before(:each) do
      @conflict = FactoryGirl.create(:conflict)
    end

    it "should return all the conflicts of employee on given date" do
      @conflict.employee.get_conflicts_on(@conflict.start_time.to_date).should_not be_blank
    end
  end
end
