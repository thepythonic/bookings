class CreateBookingsTemplateSlots < ActiveRecord::Migration
  def change
    create_table :bookings_template_slots do |t|
      t.string :day
      t.integer :from_time
      t.integer :to_time
      t.integer :reservable_id, index: true

      t.timestamps
    end
  end
end
