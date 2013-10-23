# This migration comes from bookings (originally 20131013175854)
class CreateBookingsAppointments < ActiveRecord::Migration
  def change
    create_table :bookings_appointments do |t|
      t.datetime :from
      t.integer :duration
      t.integer :position
      t.text :note

      t.timestamps
    end
  end
end
