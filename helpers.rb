require_relative './data'


  def hour_of_day_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Time of Day')
    data_table.new_column('number', 'Portland')
    data_table.new_column('number', 'NYC')
    data_table.add_rows(4)
    data_table.set_cell(0,0, 'Midnight - 6 AM')
    data_table.set_cell(0,1, @pdx_analyzer.time_of_day(1))
    data_table.set_cell(0,2, @nyc_analyzer.time_of_day(1))
    data_table.set_cell(1,0, '6 AM - Noon')
    data_table.set_cell(1,1, @pdx_analyzer.time_of_day(2))
    data_table.set_cell(1,2, @nyc_analyzer.time_of_day(2))
    data_table.set_cell(2,0, 'Noon - 6 PM')
    data_table.set_cell(2,1, @pdx_analyzer.time_of_day(3))
    data_table.set_cell(2,2, @nyc_analyzer.time_of_day(3))
    data_table.set_cell(3,0, '6 PM - Midnight')
    data_table.set_cell(3,1, @pdx_analyzer.time_of_day(4))
    data_table.set_cell(3,2, @nyc_analyzer.time_of_day(4))

    option = {width: 800, height: 500, title: "Hour of Day"}
    @time_chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, option)
  end


  def day_of_week_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Day of Week')
    data_table.new_column('number', 'Portland')
    data_table.new_column('number', 'NYC')
    data_table.add_rows(7)
    data_table.set_cell(0,0, 'Sunday')
    data_table.set_cell(0,1, Post.portland.posted_on_day_of_week('sunday').count)
    data_table.set_cell(0,2, Post.new_york.posted_on_day_of_week('sunday').count)
    data_table.set_cell(1,0, 'Monday')
    data_table.set_cell(1,1, Post.portland.posted_on_day_of_week('monday').count)
    data_table.set_cell(1,2, Post.new_york.posted_on_day_of_week('monday').count)
    data_table.set_cell(2,0, 'Tuesday')
    data_table.set_cell(2,1, Post.portland.posted_on_day_of_week('tuesday').count)
    data_table.set_cell(2,2, Post.new_york.posted_on_day_of_week('tuesday').count)
    data_table.set_cell(3,0, 'Wednesday')
    data_table.set_cell(3,1, Post.portland.posted_on_day_of_week('wednesday').count)
    data_table.set_cell(3,2, Post.new_york.posted_on_day_of_week('wednesday').count)
    data_table.set_cell(4,0, 'Thursday')
    data_table.set_cell(4,1, Post.portland.posted_on_day_of_week('thursday').count)
    data_table.set_cell(4,2, Post.new_york.posted_on_day_of_week('thursday').count)
    data_table.set_cell(5,0, 'Friday')
    data_table.set_cell(5,1, Post.portland.posted_on_day_of_week('friday').count)
    data_table.set_cell(5,2, Post.new_york.posted_on_day_of_week('friday').count)
    data_table.set_cell(6,0, 'Saturday')
    data_table.set_cell(6,1, Post.portland.posted_on_day_of_week('saturday').count)
    data_table.set_cell(6,2, Post.new_york.posted_on_day_of_week('saturday').count)
    option = {width: 800, height: 500, title: "Day of Week"}
    @day_chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, option)
  end

  def pdx_who_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Who for Whom')
    data_table.new_column('number', 'Posts')
    data_table.add_rows(5)
    data_table.set_cell(0,0, 'Men for men')
    data_table.set_cell(0,1, Post.portland.for_category('m4m').count)
    data_table.set_cell(1,0, 'Men for women')
    data_table.set_cell(1,1, Post.portland.for_category('m4w').count)
    data_table.set_cell(2,0, 'Women for women')
    data_table.set_cell(2,1, Post.portland.for_category('w4w').count)
    data_table.set_cell(3,0, 'Women for men')
    data_table.set_cell(3,1, Post.portland.for_category('w4m').count)
    data_table.set_cell(4,0, 'Unspecified')
    data_table.set_cell(4,1, Post.portland.unknown_category.count)
    option = {width: 475, height: 400, title: "Portland"}
    @pdx_who_chart = GoogleVisualr::Interactive::PieChart.new(data_table, option)
  end

  def nyc_who_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Who for Whom')
    data_table.new_column('number', 'Posts')
    data_table.add_rows(5)
    data_table.set_cell(0,0, 'Men for men')
    data_table.set_cell(0,1, Post.new_york.for_category('m4m').count)
    data_table.set_cell(1,0, 'Men for women')
    data_table.set_cell(1,1, Post.new_york.for_category('m4w').count)
    data_table.set_cell(2,0, 'Women for women')
    data_table.set_cell(2,1, Post.new_york.for_category('w4w').count)
    data_table.set_cell(3,0, 'Women for men')
    data_table.set_cell(3,1, Post.new_york.for_category('w4m').count)
    data_table.set_cell(4,0, 'Unspecified')
    data_table.set_cell(4,1, Post.new_york.unknown_category.count)

    option = {width: 475, height: 400, title: "New York City"}
    @nyc_who_chart = GoogleVisualr::Interactive::PieChart.new(data_table, option)
  end
