require "bookings/engine"

module Bookings
  mattr_accessor :customer_class_name
  mattr_accessor :reservable_class_name

  # limit displaying agenda start/end time 
  mattr_accessor :min_time
  @@min_time = '00:00'
  mattr_accessor :max_time
  @@max_time = '24:00'

  # each hour has many slots, slot represents XX minutes
  mattr_accessor :slot_minutes
  @@slot_minutes = 15

  mattr_accessor :customer_search_fields
  @@customer_search_fields = [:email, :time_zone]

  # controle if
  mattr_accessor :allow_cancellation
  @@allow_cancellation = true

  mattr_accessor :allow_reschedule
  @@allow_reschedule = true

  # mattr_accessor :allow_cancellation
  # @@allow_cancellation = ture
  #  mattr_accessor :allow_reschedule
  # @@allow_reschedule = ture

  def self.customer
  	Bookings.customer_class_name.to_s.constantize
  end

  def self.reservable
  	Bookings.reservable_class_name.to_s.constantize
  end

  def self.setup
    yield self
  end

end

