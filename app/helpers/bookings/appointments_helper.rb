module Bookings
  module AppointmentsHelper
  
  	def reservables_links
  		links = @reservables.collect do |reservable|
							 link_to reservable.email, reservable_appointments_path(reservable), class: ("current" if reservable == @reservable)
							end
  		raw links.join(' | ')
  	end
  end
end
