module Bookings
  class TemplateSlot < ActiveRecord::Base
    belongs_to :reservable

    validates :from_time, :to_time, presence: true
  end

end
