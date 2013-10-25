require_dependency "bookings/application_controller"

module Bookings
  class CustomersController < ApplicationController


    def find
      @customers = Bookings.customer_class.to_s.constantize.where("id = ? OR email LIKE ?", params[:term], "%#{params[:term]}%")
      render json: @customers
    end
  end
end
