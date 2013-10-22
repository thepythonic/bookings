require_dependency "bookings/application_controller"

module Bookings
  class TemplateSlotsController < ApplicationController
    before_action :set_template_slot, only: [:show, :edit, :update, :destroy]

    # GET /template_slots
    def index
      @template_slots = TemplateSlot.all
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

      if @template_slot.save
        redirect_to @template_slot, notice: 'Template slot was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /template_slots/1
    def update
      if @template_slot.update(template_slot_params)
        redirect_to @template_slot, notice: 'Template slot was successfully updated.'
      else
        render action: 'edit'
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
        params.require(:template_slot).permit(:day, :from_time, :to_time, :reservable_id)
      end
  end
end
