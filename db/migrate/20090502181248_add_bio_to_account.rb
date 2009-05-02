class AddBioToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :bio, :text
  end

  def self.down
    remove_column :accounts, :bio
  end
end
