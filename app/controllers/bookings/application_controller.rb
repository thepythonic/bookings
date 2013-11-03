module Bookings
  class ApplicationController < ActionController::Base


  	private 
  		def reservable_only
  			unless current_user && current_user.is_a?(Bookings.reservable)
  				redirect_to appointments_welcome_path , alert: 'you are not allowed to visit that url!'
  			end
  		end

  end
end
