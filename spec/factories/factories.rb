# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :doctor, class: Bookings.reservable do
    sequence :email do |t| 
      "dr#{t}@test.com"
    end
    password "12341234"
    type 'Doctor'

    after(:create) { |dr| dr.time_slots << FactoryGirl.create(:time_slot) }
  end

  factory :patient, class: Bookings.customer do
    sequence :email do |t| 
      "patient#{t}@test.com"
    end
    password "12341234"
    type 'Patient'
  end

  factory :appointment, class: Bookings::Appointment do
    from_time DateTime.now + 1.hour
    to_time DateTime.now + 1.5.hour
    association :reservable, factory: :doctor 
    association :customer, factory: :patient
  end

  factory :time_slot, class: Bookings::TimeSlot do
    from_time 1.hour.ago
    to_time DateTime.now + 7.hour
    recurring 1 
  end

end
