class AddBlogTitleToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :blog_title, :string
  end

  def self.down
    remove_column :accounts, :blog_title
  end
end
