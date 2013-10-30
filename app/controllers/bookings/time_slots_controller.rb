require_dependency "bookings/application_controller"

module Bookings
  class TimeSlotsController < ApplicationController
    before_action :set_time_slot, only: [:show, :edit, :update, :destroy]
    
    respond_to :json, :html

    def slots
      @time_slots = current_user.time_slots.all
      render json: @time_slots, each_serializer: Bookings::TimeSlotSerializer
    end

    # GET /time_slots
    def index
      @time_slots = current_user.time_slots.all
      @time_slot = current_user.time_slots.new
    end

    # GET /time_slots/1
    def show
    end

    # GET /time_slots/new
    def new
      @time_slot = current_user.time_slots.new
    end

    # GET /time_slots/1/edit
    def edit
    end

    # POST /time_slots
    def create
      @time_slot = current_user.time_slots.new(time_slot_params)
      recurring = time_slot_params[:recurring].to_i
      @slots = []
      if @time_slot.save
        @time_slot.update_attribute(:parent, @time_slot)
        @slots << @time_slot
        @slots + @time_slot.create_children
        
        render json: @slots, each_serializer: Bookings::TimeSlotSerializer
      else
        respond_with(@time_slot) do |format|
          format.html { render :action => :new }
        end
      end

    end

    # PATCH/PUT /time_slots/1
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

    # DELETE /time_slots/1
    def destroy
      @time_slot.destroy
      redirect_to time_slots_url, notice: 'Time slot was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_time_slot
        @time_slot = current_user.time_slots.find(params[:id])
      end
      # Only allow a trusted parameter "white list" through.
      def time_slot_params
        params.require(:time_slot).permit(:from_time, :to_time, :recurring)
      end
  end
end
