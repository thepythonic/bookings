class TemplateSlotsSerializer < ActiveModel::Serializer
  attributes :id, :day, :start, :end, :title, :recurring

  #TODO HZ: first day is Sunday
  def week_days
  	DateTime::DAYNAMES
  end

  #TODO HZ: get start_day from configuration
  def beginning_of_this_week
  	DateTime.now.beginning_of_week(start_day= :sunday)
  end

  def start
  	h_m = object.from_time.split(':')
  	format_date(h_m)
  end

  def end
  	h_m = object.to_time.split(':')
  	format_date(h_m)
  end

  def title
  	object.id
  end

 	private
 	def format_date(hour_minute)
 		day = beginning_of_this_week
  	day + week_days.index(object.day) + hour_minute[0].to_i.hour + hour_minute[1].to_i.minute
 	end
end
