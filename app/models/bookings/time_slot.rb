module Bookings
  class TimeSlot < ActiveRecord::Base
    require 'duration'

  	belongs_to :reservable, class_name: Bookings.reservable_class.to_s
  	belongs_to :parent, class_name: 'Bookings::TimeSlot'
  	has_many :children, class_name: 'Bookings::TimeSlot', foreign_key: "parent_id"

    include Duration

    def create_children
      (1...recurring).collect do |i| 
        self.class.create(from_time: from_time + i.weeks, to_time: to_time + i.weeks, 
                          parent: self, recurring: recurring, reservable_id: reservable_id)
      end
    end

    def update_children
      #TODO HZ: Add comments here
      children = self.parent.children
      index = children.index(self)
      slots = []

      #update existing slots with date/time
      children.each_with_index do |slot, i|
        slots << slot.update_attributes(from_time: from_time - (index-i).weeks, to_time: to_time - (index-i).weeks, 
                               parent: self, recurring: recurring, reservable_id: reservable_id)
      end

      lnth = children.length

      slots += (lnth...recurring).to_a.collect do |i|
        self.class.create(from_time: from_time + (i-index).weeks, to_time: to_time + (i-index).weeks, 
                          parent: self, recurring: recurring, reservable_id: reservable_id)
      end
      if recurring < lnth
        children[recurring .. -1].map(&:destroy)
      end
    end

  end
end
