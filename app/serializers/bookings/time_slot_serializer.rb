module Bookings
  class TimeSlotSerializer < ActiveModel::Serializer
    attributes :id, :start, :end, :title, :recurring


    def start
    	object.from_time
    end

    def end
    	object.to_time
    end

    def title
    	object.id
    end

  end
end
