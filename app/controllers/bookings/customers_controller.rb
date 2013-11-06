require_dependency "bookings/application_controller"

module Bookings
  class CustomersController < ApplicationController
  	before_action :admin_only

    def find
    	# TODO HZ: search attributes from configuration
      @customers = Bookings.customer.where("id = ? OR email LIKE ?", params[:term], "%#{params[:term]}%")
      render json: @customers
    end

    def admin_only
    	unless current_user && current_user.can_find_customers?
    		render json: {errors: {error: ["action not allowed"]}}
    	end
    end
  end
end
