module Bookings
  class AppointmentSerializer < ActiveModel::Serializer
    attributes :id, :start, :end, :title, :recurring, :time_slot

    def recurring
      begin
        object.recurring
      rescue 
        nil
      end
    end

    def time_slot
      begin
        true if object.recurring
      rescue 
        false
      end
    end

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