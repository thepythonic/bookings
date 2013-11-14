# Bookings

This project rocks and uses MIT-LICENSE.

```ruby
git clone git@github.com:thepythonic/bookings.git
```

Gemfile

```ruby
gem 'bookings', path: PATH_TO_REPO
bundle install
```

###Reservable is the item/person that will be booked  (lesson, doctor)
###Customer is the persion who is going to book (student, patient)

##Example using a doctor & patient

create initializers/bookings.rb and define the reservable & customer class names
```ruby
Bookings.setup do |config|
  config.reservable_class_name = 'Doctor'
  config.customer_class_name = 'Patient'
end
```

### User must have a time_zone field

User model must provide the follwoing methods.

```ruby
  def is_reservable?
    if self.is_a? Patient
      return false
    end
    true
  end

  def is_customer?
    if self.is_a? Patient
      return true
    end
    false
  end

  def is_admin?
    self.admin
  end
  
  def can_find_customers?
    self.admin
  end

  def allow_notification?
    true
  end
```

create a Doctor model
```ruby
class Doctor < User
  has_many :appointments, class_name: 'Bookings::Appointment', foreign_key: 'reservable_id'
  has_many :time_slots, class_name: 'Bookings::TimeSlot', foreign_key: 'reservable_id'
end
```

create a Patient model
```ruby
class Patient < User
  has_many :appointments, class_name: 'Bookings::Appointment', foreign_key: 'customer_id'
end
```

##Configurations
```ruby
  #Agenda start/end time
  config.min_time = '08:00'
  #default is '00:00'
  config.max_time = '15:00'
  # default is '24:00'

  # each hour has many slots, slot represents XX minutes
  config.slot_minutes = 15
  # default is 15
  
  # fields to search for in the autocomplete  (By Admin)
  config.customer_search_fields = [:email, :time_zone]
  #default is [:email, :time_zone]

  # controle cancel/reschedule
  config.allow_cancellation = true
  #default is true
  config.allow_reschedule = true
  #default is true
```



