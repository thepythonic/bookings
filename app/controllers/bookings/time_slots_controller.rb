require_dependency "bookings/application_controller"

module Bookings
  class TimeSlotsController < ApplicationController
    before_action :set_time_slot, only: [:show, :edit, :update, :destroy]
    before_action :set_reservable, except: [:my_time_slots]
    

    respond_to :json, :html

    def slots
      @time_slots = @reservable.time_slots.all
      render json: @time_slots, each_serializer: TimeSlotSerializer
    end

    def index
      @time_slot = @reservable.time_slots.new
    end

    def show
    end

    def new
      @time_slot = @reservable.time_slots.new
    end

    def edit
    end

    def create
      @time_slot = @reservable.time_slots.new(time_slot_params)
      
      if @time_slot.save
        @time_slot.update_attribute(:parent, @time_slot)
        @time_slot.create_children
        
        render json: [@time_slot], each_serializer: TimeSlotSerializer
      else
        respond_with(@time_slot) do |format|
          format.html { render :action => :new }
        end
      end
    end

    def update
      if @time_slot.update(time_slot_params)
        @time_slot.update_children
        #TODO HZ:: check if @time_slot still exist not deleted by the update_children
        render json: [@time_slot], each_serializer: TimeSlotSerializer
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

    def my_time_slots
      @reservable = current_user
      @reservables = [current_user]
      @time_slot = @reservable.time_slots.new
      render :index
    end

    private
      def set_time_slot
        @time_slot = current_user.time_slots.find(params[:id])
      end

      def time_slot_params
        params.require(:time_slot).permit(:from_time, :to_time, :recurring)
      end

      def set_reservable
        @reservable =  Bookings.reservable.find(params[:reservable_id])
      end

      def set_reservables
        @reservables = Bookings.reservable.all
      end

  end
end
