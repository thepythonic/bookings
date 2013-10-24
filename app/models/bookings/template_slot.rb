module Bookings
  class TemplateSlot < ActiveRecord::Base
    belongs_to :reservable

    validates :from_time, :to_time, presence: true
    validates :day, inclusion: DateTime::DAYNAMES

    validate :no_overlap

    def no_overlap
    	# TODO HZ: reservable.time_slots.where
    	results = Bookings::TemplateSlot.where("(from_time < ? AND to_time > ?) OR (from_time < ? AND to_time > ?)", from_time, from_time, to_time, to_time)
    	results = results.where('day = ?', day)
    	puts "s"*30
    	puts results.map(&:id)
    	puts "a"*30
    	results = results.where("id != ?",  id) unless new_record?
    	errors.add(:from_date, "Can't overlap another slot") if results.exists?
    end
  end

end
