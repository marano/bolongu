class AddPositionToGalleryPhoto < ActiveRecord::Migration
  def self.up
    add_column :gallery_photos, :position, :integer
  end

  def self.down
    remove_column :gallery_photos, :position
  end
end
