class AddCachedTagListToTweet < ActiveRecord::Migration
  def self.up
    add_column :tweets, :cached_tag_list, :string
  end

  def self.down
    remove_column :tweets, :cached_tag_list
  end
end
