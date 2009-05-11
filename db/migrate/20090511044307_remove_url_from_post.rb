class RemoveUrlFromPost < ActiveRecord::Migration
  def self.up
    remove_column :posts, :url
  end
  
  def self.down
    add_column :posts, :url, :string
    Post.all.each { |post| post.make_url }
  end
end
