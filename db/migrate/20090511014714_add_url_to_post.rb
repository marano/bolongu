class AddUrlToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :url, :string
    Post.all.each { |post| post.make_url }
  end

  def self.down
    remove_column :posts, :url
  end
end
