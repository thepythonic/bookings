module Bookings
  class TimeSlot < ActiveRecord::Base

  	belongs_to :reservable, class_name: Bookings.reservable_class.to_s
  	belongs_to :parent, class_name: 'Bookings::TimeSlot'
  	has_many :children, class_name: 'Bookings::TimeSlot', foreign_key: "parent_id"

    require 'duration'
    include Duration

    
    

    def merge_time_slots
      # TODO HZ: reservable.time_slots.where
      results = Bookings::TimeSlot.where('from_time = :to_time OR to_time = :from_time', {to_time: to_time, from_time: from_time})
      return if results.empty?

      min_from = [results.map(&:from_time).min, from_time].min
      max_to = [results.map(&:to_time).max, to_time].max

      self.from_time = min_from
      self.to_time = max_to
      # results.map(&:destroy)
    end
  end
end
