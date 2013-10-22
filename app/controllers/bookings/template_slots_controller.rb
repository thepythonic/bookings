require_dependency "bookings/application_controller"

module Bookings
  class TemplateSlotsController < ApplicationController
    before_action :set_template_slot, only: [:show, :edit, :update, :destroy]

    # GET /template_slots
    def index
      @template_slot = TemplateSlot.new

    end

    def slots
      y, m,d = 2013, 10,22
      @x= [
      {title: "All Day Event", start: DateTime.new(y, m, 1, 8)},
      {title: "Long Event",
      start: DateTime.new(y, m, d - 5),
      :end => DateTime.new(y, m, d - 2),
      name: "xxxx"},
      {id: 999,
      title: "Repeating Event",
      start: DateTime.new(y, m, d - 3, 16),
      allDay: false},
      {id: 999,
      title: "Repeating Event",
      start: DateTime.new(y, m, d + 4, 16),
      allDay: false},
      {title: "Meeting",
      start: DateTime.new(y, m, d, 10),
      allDay: false},
      {title: "Lunch",
      start: DateTime.new(y, m, d, 12),
      :end => DateTime.new(y, m, d, 14),
      allDay: false},
      {title: "Birthday Party",
      start: DateTime.new(y, m, d + 1, 19),
      :end => DateTime.new(y, m, d + 1, 22),
      allDay: false},
     {title: "Click for Google",
      start: DateTime.new(y, m, 28),
      :end => DateTime.new(y, m, 29),
      url: "http://google.com/"}
    ]
      render json: @x
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
