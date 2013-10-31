module Bookings
  class TimeSlot < ActiveRecord::Base
    require 'duration'

  	belongs_to :reservable, class_name: Bookings.reservable_class_name
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
      children = self.parent.children
      index = children.index(self)
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
