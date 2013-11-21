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


end