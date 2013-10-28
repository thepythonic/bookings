module Bookings
  module TimeSlotsHelper

    def minutes_span_options
      (0..59).step(15).to_a.map{|t| [t, "%02d"%t ]}
    end
    def hours_span_options
      (0..23).map{|t| [t, "%02d"%t]}
    end
    def week_recurring_options
      (1..52).to_a.map{|t| ["#{t} Week", t]}
    end
    def day_names_options
      DateTime::DAYNAMES.map { |d| [d,d] }
    end
  end
end
