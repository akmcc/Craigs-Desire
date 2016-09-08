class DataAnalyzer

  attr_reader :data_source

  def initialize(data_source)
    @data_source = data_source
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
    @data_source.select { |post| hours.include? post.posted_at.hour}.count
  end
end