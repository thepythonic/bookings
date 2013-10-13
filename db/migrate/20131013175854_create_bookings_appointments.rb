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
