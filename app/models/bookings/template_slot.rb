module Bookings
  class TemplateSlot < ActiveRecord::Base
    belongs_to :reservable

    validates :from_time, :to_time, presence: true
    validates :day, inclusion: DateTime::DAYNAMES

    validate :no_intersection
    validate :from_less_than_to

    after_save :merge_template_slots

    def no_intersection
    	# TODO HZ: reservable.time_slots.where
    	results = Bookings::TemplateSlot.where("(from_time >= :from_time AND from_time < :to_time) OR
                (:from_time >= from_time AND :from_time < to_time)", {from_time: from_time, to_time: to_time})
    	results = results.where('day = ?', day)
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
      puts  "S" * 50
      results = Bookings::TemplateSlot.where('day = :day AND (from_time = :to_time OR to_time = :from_time)', {day: day, to_time: to_time, from_time: from_time})
      puts results
      unless results.empty?

      end
    end

  end

end
