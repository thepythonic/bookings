require_dependency "bookings/application_controller"

module Bookings
  class AppointmentsController < ApplicationController
    before_action :set_appointment, only: [:show, :edit, :update, :destroy]
    before_action :set_customers_employees, only: [:new, :edit]

    respond_to :json, :html

    # GET /appointments
    def index
      @appointments = Appointment.all
      @appointment = Appointment.new
      respond_with(@appointments)
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
      @appointment = Appointment.new(appointment_params)

      if @appointment.save
        respond_with(@appointment, :status => :created, :location => @appointment) do |format|
          format.html { redirect_to @appointment,  notice: 'Appointment was successfully created.' }
        end
      else
        respond_with(@appointment) do |format|
          format.html { render :action => :new }
        end
      end
    end

    # PATCH/PUT /appointments/1
    def update
      if @appointment.update(appointment_params)
        respond_with(@appointment, :status => :created, :location => @appointment) do |format|
          format.json { render json: @appointment }
          format.html { redirect_to @appointment,  notice: 'Appointment was successfully updated.' }
        end
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

    def slots
      #TODO HZ: check here!
      slots = current_user.template_slots.all.to_a
      appointments = Appointment.all.to_a 
      all = appointments + slots
      render json: all, each_serializer: Bookings::AppointmentsSerializer
    end

    def appointments_for_employee
      @employee = Employee.find(params[:employee])
      @appointments = @employee.appointments
      render :index
    end

    def appointments_for_reservable
      @customer = Customer.find(params[:customer])
      @appointments = @customer.appointments
      render :index
    end

    def within_date_range
      @appointments = Appointment.where("`from` <= ? and `from` >= ?", DateTime.strptime(params[:end], "%s"), DateTime.strptime(params[:start], "%s"))
      @appointments = @appointments.group_by { |t| t.from.beginning_of_day }
      respond_with(@appointments)
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_appointment
        @appointment = Appointment.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def appointment_params
        params.require(:appointment).permit(:customer_id, 'from_time(1i)', 'from_time(2i)', 'from_time(3i)', 'from_time(4i)', 'from_time(5i', 
          'to_time(1i)', 'to_time(2i)', 'to_time(3i)', 'to_time(4i)', 'to_time(5i)')
      end

      def set_customers_employees
        @customers = Bookings.customer_class.to_s.constantize.all
        @employees = Bookings.reservable_class.to_s.constantize.all
      end
  end
end
