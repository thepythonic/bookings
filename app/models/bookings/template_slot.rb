module Bookings
  class TemplateSlot < ActiveRecord::Base
    belongs_to :reservable
  end
end
