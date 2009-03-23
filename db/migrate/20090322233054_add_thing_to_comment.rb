class AddThingToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :thing_id, :integer
  end

  def self.down
    remove_column :comments, :thing_id
  end
end
