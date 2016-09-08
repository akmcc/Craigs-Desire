class AddColumsToStats < ActiveRecord::Migration
  def change
    remove_column :stats, :adjectives
    add_column :stats, :pdx_probability, :text
    add_column :stats, :pdx_nouns, :text
    add_column :stats, :nyc_probability, :text
    add_column :stats, :nyc_nouns, :text

  end
end
