require_dependency "bookings/application_controller"

module Bookings
  class AppointmentsController < ApplicationController
    before_action :set_reservable
    before_action :set_appointment, only: [:show, :edit, :update, :destroy]
    before_action :set_customers_employees, only: [:index]

    respond_to :json, :html

    # GET /appointments
    def index
      # @appointments = @reservable.appointments.all
      @appointment = @reservable.appointments.new
      # respond_with(@appointments)
    end

    # GET /appointments/1
    def show
    end

    # GET /appointments/new
    def new
      @appointment = Appointment.new
    end

    # GET /appointments/1/edit
    def edit
    end

    # POST /appointments
    def create
      @appointment = @reservable.appointments.new(appointment_params)

      if @appointment.save
        render json: [@appointment], each_serializer: Bookings::AppointmentSerializer
      else
        respond_with(@appointment) do |format|
          format.html { render :action => :new }
        end
      end
    end

    # PATCH/PUT /appointments/1
    def update
      if @appointment.update(appointment_params)
        render json: [@appointment], each_serializer: Bookings::AppointmentSerializer
      else
        respond_with(@appointment) do |format|
          format.html { render :action => :edit }
        end
      end
    end

    # DELETE /appointments/1
    def destroy
      @appointment.destroy
      redirect_to appointments_url, notice: 'Appointment was successfully destroyed.'
    end

     def appointments_for_reservable
      slots = @reservable.time_slots.all.to_a
      appointments = @reservable.appointments.all.to_a
      all = appointments + slots
      render json: all, each_serializer: Bookings::AppointmentSerializer
    end

  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_reservable
        @reservable =  Bookings.reservable_class.to_s.constantize.find(params[:reservable_id])
      end

      def set_appointment
        @appointment = @reservable.appointments.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def appointment_params
        #TODO HZ: get customer from current_user
        params.require(:appointment).permit(:customer_id, 'from_time', 'to_time')
      end

      def set_customers_employees
        # @customers = Bookings.customer_class.to_s.constantize.all
        @reservables = Bookings.reservable_class.to_s.constantize.all
      end
  end
end
