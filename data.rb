class DataAnalyzer

  attr_reader :data_source

  def initialize(data_source)
    @data_source = data_source
  end

  def  first_and_last
    times = []
    @data_source.each do |post|
      times << Time.parse(post.date_posted)
    end
    [times.sort[0].asctime, times.sort[-1].asctime]
  end

  def get_wday(day_of_week)
    case day_of_week.downcase
    when "sunday" then 0
    when "monday" then 1
    when "tuesday" then 2
    when "wednesday" then 3
    when "thursday" then 4
    when "friday" then 5
    when "saturday" then 6
    end
  end

  def posts_from(day_of_week)
    count = 0

    wday = get_wday(day_of_week)

    @data_source.each do |post|
      if wday == Time.parse(post.date_posted).wday
        count += 1
      end
    end
    if how_many(day_of_week) > 0
      return count / how_many(day_of_week)
    else
      return 0
    end
  end

  #tells you how many mondays (or whatever day) exists in the db
  def how_many(day_of_week)
    wday = get_wday(day_of_week)
    @data_source.map {|post| Time.parse(post.date_posted).yday if Time.parse(post.date_posted).wday == wday }.compact.uniq.size
  end

  def post_count
    @data_source.size
  end

  def count_who_for_whom(who_for_whom)
    @data_source.where("title like '%#{who_for_whom}%'").count
  end

  def number_of_unspecified
    @data_source.count - (count_who_for_whom('m4m') + count_who_for_whom('m4w') + count_who_for_whom('w4w') + count_who_for_whom('w4m'))
  end


  def get_hours(quarter_of_day)
    case quarter_of_day
    when 1 then (0..5)
    when 2 then (6..11)
    when 3 then (12..17)
    when 4 then (18..23)
    end
  end

  # quarter_of_day: 1 for hours 0 - 5, 2 for 6 - 11, 3 for 12 -17, 4 for 18 - 23
  def time_of_day(quarter_of_day)
    hours = get_hours(quarter_of_day)
    @data_source.select { |post| hours.include? Time.parse(post.date_posted).hour}.count
  end
end