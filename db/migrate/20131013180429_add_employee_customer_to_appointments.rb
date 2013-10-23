class AddEmployeeCustomerToAppointments < ActiveRecord::Migration
  def change
    add_reference :bookings_appointments, :reservable, index: true
    add_reference :bookings_appointments, :customer, index: true
  end
end
