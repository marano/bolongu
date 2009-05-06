class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.references :notifiable, :polymorphic => true
      t.datetime :published_at
      t.references :publisher
      t.boolean :private_content, :default => false

      t.timestamps
    end
    
    Notification.recreate_all!
  end

  def self.down
    drop_table :notifications
  end
end
