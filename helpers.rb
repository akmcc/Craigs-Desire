require_relative './data'

helpers do

  def who4who_graph
    Gchart.pie(:title => "Who is looking for whom", :title_color => 'ffffff', :title_size => '72', :size => '400x300', :bg => '303030', :bar_colors => '53868b,7ac5cd,98f5ff,39b7cd,c3e4ed', :data => [@data.count_who_for_whom('m4m'), @data.count_who_for_whom('m4w'), @data.count_who_for_whom('w4w'), @data.count_who_for_whom('w4m'), @data.number_of_unspecified], :legend => ['men4men', 'men4women', 'women4women', 'women4men', 'unspecified'], :title => 'Who seeks whom')
  end

  def word_freq_graph
    Gchart.bar(:size => '400x300', :bg => '303030', :max_value => 112, :min_value => 0, :axis_with_labels => 'y', :legend => ["love", "hate", "sexy", "lonely"], :bar_colors => ['ff0000','009999','9fee00','a60000'], :data => [[77], [100], [50], [25]], :bar_width_and_spacing => [50, 20], :title => "Word frequency", :stacked => false)
  end

  def day_of_week_graph
    Gchart.bar(:size => '800x300', :bg => "303030", :legend => ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"], :stacked => false, :data => [[@data.posts_from("sunday")], [@data.posts_from("monday")], [@data.posts_from("tuesday")], [@data.posts_from("wednesday")], [@data.posts_from("thursday")], [@data.posts_from("friday")], [@data.posts_from("saturday")]], :bar_width_and_spacing => [65, 40] )
  end

end