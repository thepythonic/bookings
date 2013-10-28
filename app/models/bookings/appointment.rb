module Bookings
  class Appointment < ActiveRecord::Base

    default_scope -> { order('`from_time` ASC') }

    #TODO HZ: classes should be configurable
    belongs_to :reservable, class_name: Bookings.reservable_class.to_s
    belongs_to :customer, class_name: Bookings.customer_class.to_s

    require 'duration'
    include Duration


  end
end
