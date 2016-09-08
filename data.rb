class DataAnalyzer

  #seems like a bizzarely thrown together class.. need to think about this one

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
    count / how_many(day_of_week)
  end

  #tells you how many mondays (for example) exists in the db
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


end