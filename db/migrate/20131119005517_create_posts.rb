class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :date_posted
      t.string :post_id
    end
  end

  def self.down
    drop_table :posts
  end
end
