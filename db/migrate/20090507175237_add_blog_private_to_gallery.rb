class AddBlogPrivateToGallery < ActiveRecord::Migration
  def self.up
    add_column :galleries, :blog_private, :boolean, :default => false
    
    Gallery.update_all :blog_private => false
  end

  def self.down
    remove_column :galleries, :blog_private
  end
end
