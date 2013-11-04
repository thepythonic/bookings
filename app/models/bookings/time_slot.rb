module Bookings
  class TimeSlot < ActiveRecord::Base
    require 'duration'

  	belongs_to :reservable, class_name: Bookings.reservable_class_name
  	belongs_to :parent, class_name: 'TimeSlot'
  	has_many :children, class_name: 'TimeSlot', foreign_key: "parent_id"

    include Duration

    def create_children
      (1...recurring).collect do |i| 
        self.class.create(from_time: from_time + i.weeks, to_time: to_time + i.weeks, 
                          parent: self, recurring: recurring, reservable_id: reservable_id)
      end
    end

    def self.split_by_appointment(slot, appointment)
      # to hide other customers appointments from current customer.
      # split time slot if appointment intersects with it.
      slots = []
      first = TimeSlot.new(slot.attributes)
      second = TimeSlot.new(slot.attributes)
      
      first.from_time = slot.from_time 
      first.to_time = appointment.from_time
      
      second.from_time = appointment.to_time
      second.to_time = slot.to_time

      slots.push first if appointment.from_time > slot.from_time
      slots.push second if appointment.to_time < slot.to_time

      slots
    end

    def update_children
      children = self.parent.children
      index = children.index(self)
      # user can update time_slots either from the first, middle or last recurrent slots.
      # in all cases, we will get the parent time_slot, which is the first one.
      # then update all its children.
      # we have two cases if current recurring value is changed:
      # if user increased the current recurring value, then we should create new time slots.
      # if user descreased the current recurring value, then we should delete the remaining time slots from the end.
      update_all_my_parent_children(children, index)
      create_or_delete_remainings(children, index)
    end

    private
      def update_all_my_parent_children(children, index)
        # update all my parent's children with my attribute
        children.each_with_index do |slot, i|
          delta = index - i
          slot.update_attributes(from_time: from_time - delta.weeks, to_time: to_time - delta.weeks, 
                                 parent: self, recurring: recurring, reservable_id: reservable_id)
        end
      end
      
      def create_or_delete_remainings(children, index)
        # recurring value increased? then create new time slots
        # recurring value decreased? then delete latest children.
        lnth = children.length

        if recurring < lnth
          children[recurring .. -1].map(&:destroy)
        else
          (lnth...recurring).to_a.collect do |i|
            delta = i - index 
            self.class.create(from_time: from_time + delta.weeks, to_time: to_time + delta.weeks, 
                              parent: self, recurring: recurring, reservable_id: reservable_id)
          end
        end
      end
  end
end
