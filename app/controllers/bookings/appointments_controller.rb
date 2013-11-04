require_dependency "bookings/application_controller"

module Bookings
  class AppointmentsController < ApplicationController
    before_action :authenticate_user!

    before_action :set_customer, only: [:create, :update]
    before_action :set_reservable, except: [:my_appointments, :welcome]
    before_action :set_appointment, only: [:show, :edit, :update, :destroy]
    before_action :set_reservables, only: [:index, :welcome]
    before_action :reservable_only, only:[:my_appointments]

    respond_to :json, :html

    def welcome

    end

    def index
      @appointment = @reservable.appointments.new
    end

    def show
    end

    def new
      @appointment =  @reservable.appointments.new
    end

    def edit
    end

    def create
      @appointment = @reservable.appointments.new(appointment_params)
      @appointment.customer = @customer

      if @appointment.save
        render json: [@appointment], each_serializer: AppointmentSerializer
      else
        respond_with(@appointment) do |format|
          format.html { render :action => :new }
        end
      end
    end

    def update
      if @appointment.update(appointment_params)
        render json: [@appointment], each_serializer: AppointmentSerializer
      else
        respond_with(@appointment) do |format|
          format.html { render :action => :edit }
        end
      end
    end

    def destroy
      @appointment.destroy
      # redirect_to appointments_url, notice: 'Appointment was successfully destroyed.'
      render json: {success: true}
    end

    def my_appointments
      @reservable = current_user
      @reservables = [current_user]
      @appointment = @reservable.appointments.new
      render :index
    end

    def appointments_for_reservable
      slots = @reservable.time_slots.all.to_a
      appointments = @reservable.appointments.order('from_time ASC').all.to_a
      # patient should only see his appointments
      if current_user.is_customer?
        slots.each do |slot|
          appointments.each do |appointment|
            # customer can see his appointments only
            if appointment.from_time >= slot.from_time && appointment.to_time <= slot.to_time
              next if appointment.customer_id.to_s == current_user.id.to_s 
              first = TimeSlot.new(slot.attributes)
              second = TimeSlot.new(slot.attributes)
              
              first.from_time = slot.from_time 
              first.to_time = appointment.from_time
              
              second.from_time = appointment.to_time
              second.to_time = slot.to_time
              
              slots.push first if appointment.from_time > slot.from_time
              slots.push second if appointment.to_time < slot.to_time
              
              slot.from_time = nil
              slot.to_time = nil
              appointments.delete(appointment)
              break
            end
          end
        end
      elsif current_user.is_reservable? && current_user.id != @reservable.id
        # reservables can't see each othere's appointments
        appointments = []
      end

      all = appointments + slots
      
      render json: all, each_serializer: AppointmentSerializer
    end
  
    private
      def appointment_params
        params.require(:appointment).permit('from_time', 'to_time')
      end

      def set_customer
        if current_user.is_a? Bookings.customer
          @customer =  current_user 
        elsif current_user.is_admin?
          @customer = Bookings.customer.find(params[:appointment][:customer_id])
        end
      end

      def set_reservable
        @reservable =  Bookings.reservable.find(params[:reservable_id])
      end

      def set_reservables
        @reservables = Bookings.reservable.all
      end

      def set_appointment
        @appointment = @reservable.appointments.find(params[:id])
      end

  end
end
