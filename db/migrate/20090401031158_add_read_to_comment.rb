class AddReadToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :read, :boolean, :default => false
  end

  def self.down
    remove_column :comments, :read
  end
end
