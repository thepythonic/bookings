require 'test_helper'

module Bookings
  class TemplateSlotsControllerTest < ActionController::TestCase
    setup do
      @template_slot = template_slots(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:template_slots)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create template_slot" do
      assert_difference('TemplateSlot.count') do
        post :create, template_slot: { day: @template_slot.day, from_time: @template_slot.from_time, reservable_id: @template_slot.reservable_id, to_time: @template_slot.to_time }
      end

      assert_redirected_to template_slot_path(assigns(:template_slot))
    end

    test "should show template_slot" do
      get :show, id: @template_slot
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @template_slot
      assert_response :success
    end

    test "should update template_slot" do
      patch :update, id: @template_slot, template_slot: { day: @template_slot.day, from_time: @template_slot.from_time, reservable_id: @template_slot.reservable_id, to_time: @template_slot.to_time }
      assert_redirected_to template_slot_path(assigns(:template_slot))
    end

    test "should destroy template_slot" do
      assert_difference('TemplateSlot.count', -1) do
        delete :destroy, id: @template_slot
      end

      assert_redirected_to template_slots_path
    end
  end
end
