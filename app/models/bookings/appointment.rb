module Bookings
  class Appointment < ActiveRecord::Base

    default_scope -> { order('`from` ASC') }

    #TODO HZ: classes should be configurable
    belongs_to :reservable, class_name: Bookings.reservable_class.to_s
    belongs_to :customer, class_name: Bookings.customer_class.to_s
  end
end
