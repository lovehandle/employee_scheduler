require 'spec_helper'

describe Shift do
  it {
    should validate_presence_of :start_time
    should validate_presence_of :end_time
  }
end
