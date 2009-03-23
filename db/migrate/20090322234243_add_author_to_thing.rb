class AddAuthorToThing < ActiveRecord::Migration
  def self.up
    add_column :things, :author_id, :integer
  end

  def self.down
    remove_column :things, :author_id
  end
end
