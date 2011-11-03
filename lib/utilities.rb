module EmployeeScheduler
  module Utilities
    def check_type(object , type )
      raise "object needs to be of Type:: #{type.to_s}" unless object.is_a?(type)
    end
  end
end
