class Scheduling < ApplicationRecord
  belongs_to :group

  def check_day
    day = DateTime.now.wday
    case day
    when 0
      sunday
    when 1
      monday
    when 2
      tuesday
    when 3
      wednesday
    when 4
      thursday
    when 5
      friday
    when 7
      saturday
    else
      false
    end
  end
end
