class AddCoverToGalleryPhoto < ActiveRecord::Migration
  def self.up
    add_column :gallery_photos, :cover, :boolean
  end

  def self.down
    remove_column :gallery_photos, :cover
  end
end
