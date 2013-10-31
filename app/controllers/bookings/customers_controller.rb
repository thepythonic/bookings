require_dependency "bookings/application_controller"

module Bookings
  class CustomersController < ApplicationController
  	before_action :admin_only

    def find
    	# TODO HZ: from configuration
    	# TODO HZ: Admin only
      @customers = Bookings.customer.where("id = ? OR email LIKE ?", params[:term], "%#{params[:term]}%")
      render json: @customers
    end

    def admin_only
    	current_user && current_user.is_admin?
    end
  end
end
