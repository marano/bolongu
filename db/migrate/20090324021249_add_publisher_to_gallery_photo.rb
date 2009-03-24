class AddPublisherToGalleryPhoto < ActiveRecord::Migration
  def self.up
    add_column :gallery_photos, :publisher_id, :integer
  end

  def self.down
    remove_column :gallery_photos, :publisher_id
  end
end
