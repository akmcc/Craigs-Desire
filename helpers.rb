

helpers do
  def common_word(place)
    if place == "first"
      @word_counts[-1][0]
    elsif place == "second"
      @word_counts[-2][0]
    elsif place == "third"
      @word_counts[-3][0]
    elsif place == "fourth"
      @word_counts[-4][0]
    end
  end

  def common_word_count(place)
    if place == "first"
      @word_counts[-1][1]
    elsif place == "second"
      @word_counts[-2][1]
    elsif place == "third"
      @word_counts[-3][1]
    elsif place == "fourth"
      @word_counts[-4][1]
    end
  end

  def earliest_date
    @all_posts.last.date_posted
  end

  def latest_date
    @all_posts.first.date_posted
  end

  def post_count
    @all_posts.size
  end

  def count(whom_for_who)
    Post.where("title like '% #{whom_for_who} %'").count
  end

  def who4who_graph
    Gchart.pie(:size => '400x200', :data => [count('m4m'), count('m4w'), count('w4w'), count('w4m'), number_of_unspecified], :legend => ['men4men', 'men4women', 'women4women', 'women4men', 'unspecified'], :title => 'Who seeks whom')
  end

  def number_of_unspecified
    Post.all.count - (count('m4m') + count('m4w') + count('w4w') + count('w4m'))
  end


end