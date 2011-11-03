# Attributes of Employee
# 
# email                  string
# encrypted_password     string
# reset_password_token   string
# reset_password_sent_at datetime
# remember_created_at    datetime
# sign_in_count          integer
# current_sign_in_at     datetime
# last_sign_in_at        datetime
# current_sign_in_ip     string
# last_sign_in_ip        string
#
class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :conflicts
  has_many :employee_shift_assignments
  has_many :shifts, :through => :employee_shift_assignments
  
  def get_conflicts_on(date)
    #TODO :: Need to handle shifts that can span across dates in future .
    self.conflicts.where("date(start_time) = ? ", date )
  end
end
