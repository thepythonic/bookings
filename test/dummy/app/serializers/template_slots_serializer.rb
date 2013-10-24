class TemplateSlotsSerializer < ActiveModel::Serializer
  attributes :id, :day, :start, :end, :title

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
  	day = beginning_of_this_week#.change(hour: h_m[0].to_i, minute: h_m[1].to_i)
  	day + week_days.index(object.day) + h_m[0].to_i.hour + h_m[1].to_i.minute
  end

  def end
  	h_m = object.to_time.split(':')
  	day = beginning_of_this_week#.change(hour: h_m[0].to_i, minute: h_m[1].to_i)
  	day + week_days.index(object.day) + h_m[0].to_i.hour + h_m[1].to_i.minute
  end

  def title
  	object.id
  end
end
