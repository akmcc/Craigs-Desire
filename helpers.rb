
helpers do

  def first_and_last_posts
    all_times = []
    @all_posts.each do |post|
      all_times << Time.parse(post.date_posted)
    end
    [all_times.sort[0].asctime, all_times.sort[-1].asctime]
  end

  def posts_from(day_of_week)
    @count = 0
    case day_of_week.downcase
      when "sunday" then @wday = 0
      when "monday" then @wday = 1
      when "tuesday" then @wday = 2
      when "wednesday" then @wday = 3
      when "thursday" then @wday = 4
      when "friday" then @wday = 5
      when "saturday" then @wday = 6  
    end
    @all_posts.each do |post|
      if @wday == Time.parse(post.date_posted).wday
        @count += 1
      end
    end
    @count
  end

  def earliest_date #actually need to parse these times to get earliest and lastest independent of WHEN they were saved to my db
    @all_posts.last.date_posted
  end

  def latest_date #actually need to parse these times to get earliest and lastest independent of WHEN they were saved to my db
    @all_posts.first.date_posted
  end

  def post_count
    @all_posts.size
  end

  def count(whom_for_who)
    Post.where("title like '% #{whom_for_who} %'").count
  end

  def freq(word)
    @word_counts[word]
  end

  def who4who_graph
    Gchart.pie(:title => "Who is looking for whom", :title_color => 'ffffff', :title_size => '72', :size => '400x300', :bg => '303030', :bar_colors => '53868b,7ac5cd,98f5ff,39b7cd,c3e4ed', :data => [count('m4m'), count('m4w'), count('w4w'), count('w4m'), number_of_unspecified], :legend => ['men4men', 'men4women', 'women4women', 'women4men', 'unspecified'], :title => 'Who seeks whom')
  end

  def number_of_unspecified
    Post.all.count - (count('m4m') + count('m4w') + count('w4w') + count('w4m'))
  end

  def word_freq_graph
    Gchart.bar(:size => '400x300', :bg => '303030', :max_value => freq("love"), :min_value => 0, :axis_with_labels => 'y', :legend => ["love", "hate", "sexy", "lonely"], :bar_colors => ['ff0000','009999','9fee00','a60000'], :data => [[freq("love")], [freq("hate")], [freq("sexy")], [freq("lonely")]], :bar_width_and_spacing => [50, 20], :title => "Word frequency", :stacked => false)
  end

  def day_of_week_graph
    Gchart.bar(:size => '800x300', :bg => "303030", :legend => ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"], :stacked => false, :data => [[posts_from("sunday")], [posts_from("monday")], [posts_from("tuesday")], [posts_from("wednesday")], [posts_from("thursday")], [posts_from("friday")], [posts_from("saturday")]], :bar_width_and_spacing => [65, 40] )
  end


end