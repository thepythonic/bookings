class CreateBookingsTemplateSlots < ActiveRecord::Migration
  def change
    create_table :bookings_template_slots do |t|
      t.string :day
<<<<<<< HEAD
      t.string :from_time
      t.string :to_time
      t.integer :recurrence
=======
      t.time :from_time
      t.time :to_time
      t.boolean :recurring
>>>>>>> 3331f4e5fba495bf805356fc52dae68beb454f68
      t.integer :reservable_id, index: true
      
      t.timestamps
    end
  end
end
