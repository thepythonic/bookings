require 'test_helper'

module Bookings
  class TimeSlotsControllerTest < ActionController::TestCase
    setup do
      @time_slot = time_slots(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:time_slots)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create time_slot" do
      assert_difference('TimeSlot.count') do
        post :create, time_slot: { from_time: @time_slot.from_time, reservable_id: @time_slot.reservable_id, to_time: @time_slot.to_time }
      end

      assert_redirected_to time_slot_path(assigns(:time_slot))
    end

    test "should show time_slot" do
      get :show, id: @time_slot
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @time_slot
      assert_response :success
    end

    test "should update time_slot" do
      patch :update, id: @time_slot, time_slot: { from_time: @time_slot.from_time, reservable_id: @time_slot.reservable_id, to_time: @time_slot.to_time }
      assert_redirected_to time_slot_path(assigns(:time_slot))
    end

    test "should destroy time_slot" do
      assert_difference('TimeSlot.count', -1) do
        delete :destroy, id: @time_slot
      end

      assert_redirected_to time_slots_path
    end
  end
end
