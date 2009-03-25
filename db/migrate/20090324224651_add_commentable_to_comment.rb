class AddCommentableToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :commentable_id, :integer
    add_column :comments, :commentable_type, :string
    
    #Until now only posts had comments
    
    Comment.update_all ["commentable_type = ?", 'Post'] 
    
    Comment.all.each do |comment|
      comment.update_attribute :commentable_id, comment.post_id
    end
    
    remove_column :comments, :post_id
    remove_column :comments, :thing_id
  end

  def self.down
    add_column :comments, :thing_id, :integer
    add_column :comments, :post_id, :integer
  
    remove_column :comments, :commentable_type
    remove_column :comments, :commentable_id
  end
end
