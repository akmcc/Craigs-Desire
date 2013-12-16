class PostData

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

  def posts_from(day_of_week)
    count = 0
    case day_of_week.downcase
    when "sunday" then @wday = 0
    when "monday" then @wday = 1
    when "tuesday" then @wday = 2
    when "wednesday" then @wday = 3
    when "thursday" then @wday = 4
    when "friday" then @wday = 5
    when "saturday" then @wday = 6  
    end
    @data_source.each do |post|
      if @wday == Time.parse(post.date_posted).wday
        count += 1
      end
    end
    count
  end

  def post_count 
    @data_source.size
  end

  def count_who_for_whom(who_for_whom)
    Post.all.where("title like '% #{who_for_whom} %'").count
  end

  def number_of_unspecified
    Post.all.count - (count_who_for_whom('m4m') + count_who_for_whom('m4w') + count_who_for_whom('w4w') + count_who_for_whom('w4m'))
  end

end