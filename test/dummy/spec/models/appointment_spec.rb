require 'spec_helper'

describe Bookings::Appointment do

  let(:reservable) { FactoryGirl.create(:doctor) }
  let(:customers) { FactoryGirl.create_list(:patient, 3) }
  let(:appointment) { FactoryGirl.create(:appointment, customer: customers[0], reservable: reservable) }
  let(:now) { DateTime.now }
  let(:valid_from_time) { now + 2.hours }
  let(:valid_to_time) { now + 2.5.hours }
  let(:invalid_from_time) { now + 2.weeks }
  let(:invalid_to_time) { now + 2.5.weeks }


  describe "Customer" do
    context "using valid data" do
      it "should be able to book an appointment" do
        expect(appointment.id).to eq(1)
      end

      it "should be able to reschedule an appointment" do
        appointment.update_attributes(from_time: valid_from_time, to_time: valid_to_time)
        expect(appointment.from_time).to eq(valid_from_time)
        expect(appointment.to_time).to eq(valid_to_time)
      end

      it "should be able to cancel an appointment before a deadline (configured)" do
        #add status field to appointment
      end

      it "should be able to change the appointment's reservable" do    
      end

    end

    context "using invalid data" do
      it "should not be able to book if not logged in" do
        #not related to model test
      end

      it "should not be able to book if appointment is not within reservable availablility" do
        appointment.update_attributes(from_time: invalid_from_time, to_time: invalid_to_time)
        expect(appointment.errors.empty?).to_not be_true
      end

      it "should not be able to book if to_time is less than from_time" do
      end

      it "should not be able to book if appointment time is in the past" do
      end
      
      it "should not be able to reschedule if appointment time is not within reservable availablility" do
      end

      it "should not be able to reschedule if appointment time intersects with another appointment" do
      end

      it "should not be able to cancel an appointment after a deadline (configured)" do
      end

    end

  end

  describe "Admin" do
    it "should description" do
    end
  end

end
