require "bookings/engine"

module Bookings
  mattr_accessor :customer_class_name
  mattr_accessor :reservable_class_name

  def self.customer
  	Bookings.customer_class_name.to_s.constantize
  end

  def self.reservable
  	Bookings.customer_class_name.to_s.constantize
  end

end

