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
    data_table.set_cell(0,1, @pdx_analyzer.posts_from('sunday'))
    data_table.set_cell(0,2, @nyc_analyzer.posts_from('sunday'))
    data_table.set_cell(1,0, 'Monday')                        
    data_table.set_cell(1,1, @pdx_analyzer.posts_from('monday'))
    data_table.set_cell(1,2, @nyc_analyzer.posts_from('monday'))
    data_table.set_cell(2,0, 'Tuesday')                        
    data_table.set_cell(2,1, @pdx_analyzer.posts_from('tuesday'))
    data_table.set_cell(2,2, @nyc_analyzer.posts_from('tuesday'))
    data_table.set_cell(3,0, 'Wednesday')                        
    data_table.set_cell(3,1, @pdx_analyzer.posts_from('wednesday'))
    data_table.set_cell(3,2, @nyc_analyzer.posts_from('wednesday'))
    data_table.set_cell(4,0, 'Thursday')                        
    data_table.set_cell(4,1, @pdx_analyzer.posts_from('thursday'))
    data_table.set_cell(4,2, @nyc_analyzer.posts_from('thursday'))
    data_table.set_cell(5,0, 'Friday')                        
    data_table.set_cell(5,1, @pdx_analyzer.posts_from('friday'))
    data_table.set_cell(5,2, @nyc_analyzer.posts_from('friday'))
    data_table.set_cell(6,0, 'Saturday')                        
    data_table.set_cell(6,1, @pdx_analyzer.posts_from('saturday'))
    data_table.set_cell(6,2, @nyc_analyzer.posts_from('saturday'))
    option = {width: 800, height: 500, title: "Day of Week"}
    @day_chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, option)
  end

  def pdx_who_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Who for Whom')
    data_table.new_column('number', 'Posts')
    data_table.add_rows(5)
    data_table.set_cell(0,0, 'Men for men')                        
    data_table.set_cell(0,1, @pdx_analyzer.count_who_for_whom('m4m'))
    data_table.set_cell(1,0, 'Men for women')                        
    data_table.set_cell(1,1, @pdx_analyzer.count_who_for_whom('m4w'))
    data_table.set_cell(2,0, 'Women for women')                        
    data_table.set_cell(2,1, @pdx_analyzer.count_who_for_whom('w4w'))
    data_table.set_cell(3,0, 'Women for men')                        
    data_table.set_cell(3,1, @pdx_analyzer.count_who_for_whom('w4m'))
    data_table.set_cell(4,0, 'Unspecified')                        
    data_table.set_cell(4,1, @pdx_analyzer.number_of_unspecified)

  
    option = {width: 475, height: 400, title: "Portland"}
    @pdx_who_chart = GoogleVisualr::Interactive::PieChart.new(data_table, option)
  end

  def nyc_who_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Who for Whom')
    data_table.new_column('number', 'Posts')
    data_table.add_rows(5)
    data_table.set_cell(0,0, 'Men for men')                        
    data_table.set_cell(0,1, @nyc_analyzer.count_who_for_whom('m4m'))
    data_table.set_cell(1,0, 'Men for women')                        
    data_table.set_cell(1,1, @nyc_analyzer.count_who_for_whom('m4w'))
    data_table.set_cell(2,0, 'Women for women')                        
    data_table.set_cell(2,1, @nyc_analyzer.count_who_for_whom('w4w'))
    data_table.set_cell(3,0, 'Women for men')                        
    data_table.set_cell(3,1, @nyc_analyzer.count_who_for_whom('w4m'))
    data_table.set_cell(4,0, 'Unspecified')                        
    data_table.set_cell(4,1, @nyc_analyzer.number_of_unspecified)

    option = {width: 475, height: 400, title: "New York City"}
    @nyc_who_chart = GoogleVisualr::Interactive::PieChart.new(data_table, option)
  end
