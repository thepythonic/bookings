class CreateBookingsAppointments < ActiveRecord::Migration
  def change
    create_table :bookings_appointments do |t|
      t.datetime :from_time
      t.datetime :to_time
      t.text :note
      t.integer :reservable_id, index: true
      t.integer :customer_id, index: true

      t.timestamps
    end
  end
end
