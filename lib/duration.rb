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
            results = self.class.where("(from_time >= :from_time AND from_time < :to_time) OR
                      (:from_time >= from_time AND :from_time < to_time)", {from_time: from_time, to_time: to_time})
            results = results.where("id != ?",  id) unless new_record?
            results = results.where('reservable_id = ?', reservable_id) if reservable_id
            errors.add(:from_date, "Can't overlap another slot") if results.exists?
          end

          def from_less_than_to
            if from_time && to_time && from_time >= to_time
              self.errors.add(:to_time, "should be after from time.")
            end
          end

          def not_in_the_past
            self.errors.add(:from_time, "can't be in the past.") if self.from_time < DateTime.now
          end
        end
      end
    end

  end
end