class CreateBookingsTemplateSlots < ActiveRecord::Migration
  def change
    create_table :bookings_template_slots do |t|
      t.string :day
      t.time :from_time
      t.time :to_time
      t.boolean :recurring
      t.integer :reservable_id, index: true
      
      t.timestamps
    end
  end
end
