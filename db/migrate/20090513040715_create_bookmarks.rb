class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks do |t|
      t.string :title
      t.string :adress
      t.text :description
      t.references :publisher
      t.boolean :blog_private, :default => false
      t.string :cached_tag_list

      t.timestamps
    end
  end

  def self.down
    drop_table :bookmarks
  end
end
