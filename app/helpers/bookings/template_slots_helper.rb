module Bookings
  module TemplateSlotsHelper

    def minutes_span_options
      (0..60).step(15).to_a.each{|t| [t,t]}
    end
    def hours_span_options
      (0..23).each{|t| [t,t]}
    end
  end
end
