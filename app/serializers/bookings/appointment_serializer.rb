module Bookings
  class AppointmentSerializer < ActiveModel::Serializer
    attributes :id, :start, :end, :title, :recurring
    #TODO HZ: refactor, add attribute time_slot
    def recurring
      begin
        object.recurring
      rescue 
        nil
      end
    end

    #TODO HZ: get start_day from configuration
    def beginning_of_this_week
      DateTime.now.beginning_of_week(start_day= :sunday)
    end

    def week_days
      DateTime::DAYNAMES
    end

    def start
      begin
        object.recurring
        h_m = object.to_time.split(':')
        format_date h_m
      rescue
        object.from_time
      end
    end

    def end
      begin
        object.recurring
        h_m = object.to_time.split(':')
        format_date h_m
      rescue
        object.to_time
      end
    end

    def title
      object.id
    end

    private
    def format_date(hour_minute)
      day = beginning_of_this_week
      day + week_days.index(object.day) + hour_minute[0].to_i.hour + hour_minute[1].to_i.minute
    end
  end
end