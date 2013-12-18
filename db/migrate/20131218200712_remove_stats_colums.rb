class RemoveStatsColums < ActiveRecord::Migration
 def change
  remove_column :stats, :probability_hash, :adjectives
 end
end
