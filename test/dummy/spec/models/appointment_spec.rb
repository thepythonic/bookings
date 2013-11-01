require 'spec_helper'

describe Bookings::Appointment do

  let(:reservable){FactoryGirl.create(:doctor)}
  let(:customers){FactoryGirl.create_list(:patient, 3)}


  describe "Customer" do
    context "using valid data" do
      it "should be able to book an appointment" do
        appointment = FactoryGirl.create(:appointment, customer: customers[0], reservable: reservable)
        expect(appointment.id).to eq(1)
      end

      it "should be able to reschedule an appointment" do
        appointment = FactoryGirl.create(:appointment, customer: customers[0], reservable: reservable)
        from_time = DateTime.now+2.hours
        to_time = DateTime.now+2.5.hours
        appointment.update_attributes(from_time: from_time, to_time: to_time)
        expect(appointment.from_time).to eq(from_time)
        expect(appointment.to_time).to eq(to_time)
      end

      it "should be able to cancel an appointment before a deadline (configured)" do
      end

      it "should be able to change the appointment's reservable" do    
      end

    end

    context "using invalid data" do
      it "should not be able to book if not logged in" do
      end

      it "should not be able to book if appointment is not within reservable availablility" do
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
