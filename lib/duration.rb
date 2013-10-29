module Duration

  class << self
    # Add class methods
    def included(klass)
    
      if klass.ancestors.include? ActiveRecord::Base
        klass.class_eval do
          validates :from_time, :to_time, presence: true
    
          validate :no_intersection
          validate :from_less_than_to
          
          def no_intersection
            # TODO HZ: reservable.time_slots.where
            results = self.class.where("reservable_id = :reservable_id (from_time >= :from_time AND from_time < :to_time) OR
                      (:from_time >= from_time AND :from_time < to_time)", {reservable_id: reservable_id ,from_time: from_time, to_time: to_time})
            results = results.where("id != ?",  id) unless new_record?
            errors.add(:from_date, "Can't overlap another slot") if results.exists?
          end

          def from_less_than_to
            if from_time && to_time && from_time >= to_time
              self.errors.add(:to_time, "should be after from_time.")
              return false
            end
          end
        end
      end
    end

  end
end