module Bookings
  module TemplateSlotsHelper

    def minutes_span_options
      (0..60).step(15).to_a.map{|t| [t,t]}
    end
    def hours_span_options
      (0..23).map{|t| [t,t]}
    end
    def week_recurring_options
      (1..52).to_a.map{|t| ["#{t} Week", t]}
    end
  end
end
