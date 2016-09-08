class AddPostColumns < ActiveRecord::Migration
  def up
    change_table :posts do |t|
      t.datetime "posted_at"
      t.string "craigslist_id"
      t.string "category"
      t.string "state"

      t.timestamps
    end

    Post.all.each do |post|
      title, extra = post.title.split('-')
      post.title = title.strip if title
      if extra && acronym = extra.scan(/\w+4\w+/)[0]
        post.category = acronym
      end
       post.posted_at = DateTime.parse( post.date_posted )
       post.craigslist_id = post.post_id.scan(/\d+/)[0]
       state = post.city == "Portland" ? "OR" : "NY"
       post.state = state
       post.save
    end

    change_table :posts do |table|
      table.remove "date_posted"
      table.remove "post_id"
    end

  end

  def down
    change_table :posts do |t|
      t.string "date_posted"
      t.string "post_id"
    end

    Post.all.each do |post|
      post.date_posted = post.posted_at.to_s
      post.post_id = "post id: #{post.craigslist_id}"
      post.save
    end

    change_table :posts do |t|
      t.remove "posted_at"
      t.remove "craigslist_id"
      t.remove "category"
      t.remove "state"
      t.remove "created_at"
      t.remove "updated_at"
    end
  end
end
