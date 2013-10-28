require_dependency "bookings/application_controller"

module Bookings
  class TimeSlotsController < ApplicationController
    before_action :set_time_slot, only: [:show, :edit, :update, :destroy]
    
    respond_to :json, :html

    def slots
      @time_slots = current_user.time_slots.all
      render json: @time_slots, each_serializer: Bookings::TimeSlotsSerializer
    end

    # GET /time_slots
    def index
      @time_slots = current_user.time_slots.all
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

      if @time_slot.save
        respond_with(@time_slot, :status => :created, :location => @time_slot) do |format|
          format.html { redirect_to @time_slot,  notice: 'Time slot was successfully created.' }
        end
      else
        respond_with(@time_slot) do |format|
          format.html { render :action => :new }
        end
      end

    end

    # PATCH/PUT /time_slots/1
    def update
      # TODO HZ: check for recurring attribute, and create the children
      if @time_slot.update(time_slot_params)
        respond_with(@time_slot, :status => :created, :location => @time_slot) do |format|
          format.json { render json: @time_slot }
          format.html { redirect_to @time_slot,  notice: 'Time slot was successfully updated.' }
        end
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
        params.require(:time_slot).permit(:from_time_hour, :from_time_minute, 
                                          :to_time_hour, :to_time_minute, :recurring)
      end
  end
end
