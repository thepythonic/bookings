require_dependency "bookings/application_controller"

module Bookings
  class TimeSlotsController < ApplicationController
    before_action :set_time_slot, only: [:show, :edit, :update, :destroy]
    
    respond_to :json, :html

    def slots
      @time_slots = current_user.time_slots.all
      render json: @time_slots, each_serializer: Bookings::TimeSlotSerializer
    end

    def index
      @time_slot = current_user.time_slots.new
    end

    def show
    end

    def new
      @time_slot = current_user.time_slots.new
    end

    def edit
    end

    def create
      #TODO HZ: handle no recurring value.
      @time_slot = current_user.time_slots.new(time_slot_params)
      
      if @time_slot.save
        @time_slot.update_attribute(:parent, @time_slot)
        @time_slot.create_children
        
        render json: @slot, serializer: Bookings::TimeSlotSerializer
      else
        respond_with(@time_slot) do |format|
          format.html { render :action => :new }
        end
      end

    end

    def update
      if @time_slot.update(time_slot_params)
        @time_slot.update_children
        render json: [@time_slot], each_serializer: Bookings::TimeSlotSerializer
      else
        respond_with(@time_slot) do |format|
          format.html { render :action => :edit }
        end
      end

    end

    def destroy
      @time_slot.destroy
      redirect_to time_slots_url, notice: 'Time slot was successfully destroyed.'
    end

    private
      def set_time_slot
        @time_slot = current_user.time_slots.find(params[:id])
      end

      def time_slot_params
        params.require(:time_slot).permit(:from_time, :to_time, :recurring)
      end
  end
end
