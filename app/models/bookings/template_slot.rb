module Bookings
  class TemplateSlot < ActiveRecord::Base
    belongs_to :reservable

    validates :from_time, :to_time, presence: true
    validates :day, inclusion: DateTime::DAYNAMES
  end

end
