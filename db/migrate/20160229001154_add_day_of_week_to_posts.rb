class AddDayOfWeekToPosts < ActiveRecord::Migration
  def up
    change_table :posts do |t|
      t.integer "day_of_week"
    end

    Post.all.each do |post|
      post.day_of_week = post.posted_at.wday
      post.save
    end
  end

  def down
     change_table :posts do |t|
      t.remove "day_of_week"
    end
  end
end
