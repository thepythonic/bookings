# This migration comes from bookings (originally 20131022132656)
class CreateBookingsTemplateSlots < ActiveRecord::Migration
  def change
    create_table :bookings_template_slots do |t|
      t.string :day
      t.string :from_time
      t.string :to_time
      t.integer :recurring
      t.integer :reservable_id, index: true
      
      t.timestamps
    end
  end
end
