module Bookings
  class TimeSlot < ActiveRecord::Base

  	belongs_to :reservable, class_name: Bookings.reservable_class.to_s
  	belongs_to :parent, class_name: 'Bookings::TimeSlot'
  	has_many :children, class_name: 'Bookings::TimeSlot', foreign_key: "parent_id"

    validates :from_time, :to_time, presence: true
    
    validate :no_intersection
    validate :from_less_than_to

    
    def no_intersection
    	# TODO HZ: reservable.time_slots.where
    	results = Bookings::TemplateSlot.where("(from_time >= :from_time AND from_time < :to_time) OR
                (:from_time >= from_time AND :from_time < to_time)", {from_time: from_time, to_time: to_time})
    	results = results.where("id != ?",  id) unless new_record?
    	errors.add(:from_date, "Can't overlap another slot") if results.exists?
    end

    def from_less_than_to
      if from_time && to_time && from_time >= to_time
        self.errors.add(:to_time, "should be after from_time.")
        return false
      end
    end

    def merge_template_slots
      # TODO HZ: reservable.time_slots.where
      results = Bookings::TemplateSlot.where('from_time = :to_time OR to_time = :from_time', {to_time: to_time, from_time: from_time})
      return if results.empty?

      min_from = [results.map(&:from_time).min, from_time].min
      max_to = [results.map(&:to_time).max, to_time].max

      self.from_time = min_from
      self.to_time = max_to
      # results.map(&:destroy)
    end
  end
end
