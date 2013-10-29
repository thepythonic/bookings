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
      puts current_user.time_slots
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
        from_time = Time.parse(time_slot_params[:from_time])
        to_time = Time.parse(time_slot_params[:to_time]) 
        (1...recurring).each do |i| 
          params[:time_slot][:from_time] =  from_time + i.weeks
          params[:time_slot][:to_time] = to_time + i.weeks
          params[:time_slot][:parent] = @time_slots
          
          @slots << current_user.time_slots.create(time_slot_params)
        end
        render json: @slots, each_serializer: Bookings::TimeSlotSerializer
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
        params.require(:time_slot).permit(:from_time, :to_time, :recurring)
      end
  end
end
