class AddBlogPrivateToThing < ActiveRecord::Migration
  def self.up
    add_column :things, :blog_private, :boolean, :default => false
    
    Thing.update_all :blog_private => false
  end

  def self.down
    remove_column :things, :blog_private
  end
end
