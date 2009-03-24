class CreateGalleryPhotos < ActiveRecord::Migration
  def self.up
    create_table :gallery_photos do |t|
      t.string :name
      t.text :caption
      t.references :gallery

      t.timestamps
    end
  end

  def self.down
    drop_table :gallery_photos
  end
end
