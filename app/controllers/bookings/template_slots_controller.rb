require_dependency "bookings/application_controller"

module Bookings
  class TemplateSlotsController < ApplicationController
    before_action :set_template_slot, only: [:show, :edit, :update, :destroy]

    respond_to :json, :html

    # GET /template_slots
    def index
      @template_slot = TemplateSlot.new
    end

    def slots
      @template_slots_by_day = TemplateSlot.all
      render json: @template_slots_by_day, each_serializer: TemplateSlotsSerializer
    end

    def copy_to_time_slots

    end

    # GET /template_slots/1
    def show
    end

    # GET /template_slots/new
    def new
      @template_slot = TemplateSlot.new
    end

    # GET /template_slots/1/edit
    def edit
    end

    # POST /template_slots
    def create
      @template_slot = TemplateSlot.new(template_slot_params)
      @template_slot.from_time = "#{params[:from_time_hour]}:#{params[:from_time_minute]}"
      @template_slot.to_time = "#{params[:to_time_hour]}:#{params[:to_time_minute]}"
      
      if @template_slot.save
        respond_with(@template_slot, :status => :created, :location => @template_slot) do |format|
          format.html { redirect_to @template_slot,  notice: 'Template slot was successfully created.' }
        end
      else
        respond_with(@template_slot) do |format|
          format.html { render :action => :new }
        end
      end
    end

    # PATCH/PUT /template_slots/1
    def update
      @template_slot.update(template_slot_params)
      @template_slot.from_time = "#{params[:from_time_hour]}:#{params[:from_time_minute]}"
      @template_slot.to_time = "#{params[:to_time_hour]}:#{params[:to_time_minute]}"
      if @template_slot.save
        respond_with(@template_slot, :status => :created, :location => @template_slot) do |format|
          format.json { render json: @template_slot }
          format.html { redirect_to @template_slot,  notice: 'Template slot was successfully updated.' }
        end
      else
        respond_with(@template_slot) do |format|
          format.html { render :action => :edit }
        end
      end
    end

    # DELETE /template_slots/1
    def destroy
      @template_slot.destroy
      redirect_to template_slots_url, notice: 'Template slot was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_template_slot
        @template_slot = TemplateSlot.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def template_slot_params
        params.require(:template_slot).permit(:day, :from_time_hour, :from_time_minute, 
          :to_time_hour, :to_time_minute, :recurring)
      end
  end
end
