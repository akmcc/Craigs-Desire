class CreateStats < ActiveRecord::Migration
  def up
    create_table :stats do |t|
      t.text :probability_hash
      t.text :adjectives
      t.timestamps
    end
  end

  def down
    drop_table :stats
  end
end
