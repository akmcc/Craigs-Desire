
helpers do

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
    Gchart.pie(:size => '400x300', :bg => 'dfe2e2', :bar_colors => '53868b,7ac5cd,98f5ff,39b7cd,c3e4ed', :data => [count('m4m'), count('m4w'), count('w4w'), count('w4m'), number_of_unspecified], :legend => ['men4men', 'men4women', 'women4women', 'women4men', 'unspecified'], :title => 'Who seeks whom')
  end

  def number_of_unspecified
    Post.all.count - (count('m4m') + count('m4w') + count('w4w') + count('w4m'))
  end

  def word_freq_graph
    Gchart.bar(:size => '400x300', :bg => 'dfe2e2', :max_value => freq("love"), :min_value => 0, :axis_with_labels => 'y', :legend => ["love", "hate", "sexy", "lonely"], :bar_colors => ['ff0000','009999','9fee00','a60000'], :data => [[freq("love")], [freq("hate")], [freq("sexy")], [freq("lonely")]], :bar_width_and_spacing => [50, 20], :title => "Word frequency", :stacked => false)
  end


end