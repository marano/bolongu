class AddTagCacheToModels < ActiveRecord::Migration
  def self.up
    add_column :posts, :cached_tag_list, :string
    add_column :things, :cached_tag_list, :string
    add_column :galleries, :cached_tag_list, :string
    add_column :notifications, :cached_tag_list, :string
  end


  def self.down
    remove_column :posts, :cached_tag_list
    remove_column :things, :cached_tag_list
    remove_column :galleries, :cached_tag_list
    remove_column :notifications, :cached_tag_list
  end
end
