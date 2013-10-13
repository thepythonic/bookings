module Bookings
  class Appointment < ActiveRecord::Base

    #TODO HZ: classes should be configurable
    belongs_to :employee, class: 'Employee' 
    belongs_to :customer, class: 'Customer'
  end
end
