class CreateScraps < ActiveRecord::Migration
  def self.up
    create_table :scraps do |t|
      t.text :body
      t.references :author
      t.references :recipient
      t.boolean :read, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :scraps
  end
end
