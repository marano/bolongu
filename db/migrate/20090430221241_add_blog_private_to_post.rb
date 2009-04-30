class AddBlogPrivateToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :blog_private, :boolean, :default => false
    Post.update_all(:blog_private => false)
  end

  def self.down
    remove_column :posts, :blog_private
  end
end
