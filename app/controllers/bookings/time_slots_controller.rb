require_dependency "bookings/application_controller"

module Bookings
  class TimeSlotsController < ApplicationController
    before_action :set_time_slot, only: [:show, :edit, :update, :destroy]

    # GET /time_slots
    def index
      @time_slots = TimeSlot.all
    end

    # GET /time_slots/1
    def show
    end

    # GET /time_slots/new
    def new
      @time_slot = TimeSlot.new
    end

    # GET /time_slots/1/edit
    def edit
    end

    # POST /time_slots
    def create
      @time_slot = TimeSlot.new(time_slot_params)

      if @time_slot.save
        redirect_to @time_slot, notice: 'Time slot was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /time_slots/1
    def update
      if @time_slot.update(time_slot_params)
        redirect_to @time_slot, notice: 'Time slot was successfully updated.'
      else
        render action: 'edit'
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
        @time_slot = TimeSlot.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def time_slot_params
        params.require(:time_slot).permit(:from_time, :to_time, :reservable_id)
      end
  end
end
