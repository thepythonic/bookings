require_dependency "bookings/application_controller"

module Bookings
  class CustomersController < ApplicationController
  	before_action :admin_only

    def find
    	search_fields = Bookings.customer_search_fields.collect do |field|
        "#{field.to_s} LIKE :term"
      end
      @customers = Bookings.customer.where("id = :id OR #{search_fields.join(' OR ')}", {id: params[:term], term: "%#{params[:term]}%"})
      render json: @customers
    end

    def admin_only
    	unless current_user && current_user.can_find_customers?
    		render json: {errors: {error: ["action not allowed"]}}
    	end
    end
  end
end
