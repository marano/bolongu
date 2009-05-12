class AddBlogPrivateToTweet < ActiveRecord::Migration
  def self.up
    add_column :tweets, :blog_private, :boolean, :default => false
  end

  def self.down
    remove_column :tweets, :blog_private
  end
end
