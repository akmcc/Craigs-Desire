require_relative './data'

  def pdx_who4who_graph
    Gchart.pie(:title_color => 'ffffff', :title_size => '72', :title => 'Who seeks whom - PDX', :size => '400x300', :bg => 'B0B0B0', :bar_colors => '53868b,7ac5cd,98f5ff,39b7cd,c3e4ed', :data => [@pdx_analyzer.count_who_for_whom('m4m'), @pdx_analyzer.count_who_for_whom('m4w'), @pdx_analyzer.count_who_for_whom('w4w'), @pdx_analyzer.count_who_for_whom('w4m'), @pdx_analyzer.number_of_unspecified], :legend => ['men4men', 'men4women', 'women4women', 'women4men', 'unspecified'])
  end

  def nyc_who4who_graph
    Gchart.pie( :title_color => 'ffffff', :title_size => '72', :title => 'Who seeks whom - NYC', :size => '400x300', :bg => 'B0B0B0', :bar_colors => '53868b,7ac5cd,98f5ff,39b7cd,c3e4ed', :data => [@nyc_analyzer.count_who_for_whom('m4m'), @nyc_analyzer.count_who_for_whom('m4w'), @nyc_analyzer.count_who_for_whom('w4w'), @nyc_analyzer.count_who_for_whom('w4m'), @nyc_analyzer.number_of_unspecified], :legend => ['men4men', 'men4women', 'women4women', 'women4men', 'unspecified'])
  end

  def pdx_day_of_week_graph
    Gchart.bar(:size => '800x300', :bg => "B0B0B0", :legend => ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"], :stacked => false, :data => [[@pdx_analyzer.posts_from("sunday")], [@pdx_analyzer.posts_from("monday")], [@pdx_analyzer.posts_from("tuesday")], [@pdx_analyzer.posts_from("wednesday")], [@pdx_analyzer.posts_from("thursday")], [@pdx_analyzer.posts_from("friday")], [@pdx_analyzer.posts_from("saturday")]], :bar_width_and_spacing => [65, 40] )
  end

   def nyc_day_of_week_graph
    Gchart.bar(:size => '800x300', :bg => "B0B0B0", :legend => ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"], :stacked => false, :data => [[@nyc_analyzer.posts_from("sunday")], [@nyc_analyzer.posts_from("monday")], [@nyc_analyzer.posts_from("tuesday")], [@nyc_analyzer.posts_from("wednesday")], [@nyc_analyzer.posts_from("thursday")], [@nyc_analyzer.posts_from("friday")], [@nyc_analyzer.posts_from("saturday")]], :bar_width_and_spacing => [65, 40] )
  end