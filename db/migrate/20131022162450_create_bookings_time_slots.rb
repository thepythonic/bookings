class CreateBookingsTimeSlots < ActiveRecord::Migration
  def change
    create_table :bookings_time_slots do |t|
      t.datetime :from_time
      t.datetime :to_time
      t.integer :recurring
      
      t.integer :reservable_id, index: true
      t.integer :parent_id, index: true

      t.timestamps
    end
  end
end
