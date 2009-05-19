class AddStyleToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :style_text_color, :string
    add_column :accounts, :style_link_color, :string
    add_column :accounts, :style_active_color, :string
    add_column :accounts, :style_bg_color, :string
    add_column :accounts, :style_content_bg_color, :string
    
    Account.all.each do |account|      
      account.style_text_color = "#{DefaultThemeConfig['text_color']}"
      account.style_link_color = "#{DefaultThemeConfig['link_color']}"
      account.style_active_color = "#{DefaultThemeConfig['active_color']}"
      account.style_bg_color = "#{DefaultThemeConfig['bg_color']}"
      account.style_content_bg_color = "#{DefaultThemeConfig['content_bg_color']}"
      account.save
    end
  end

  def self.down
    remove_column :accounts, :style_content_bg_color
    remove_column :accounts, :style_bg_color
    remove_column :accounts, :style_active_color
    remove_column :accounts, :style_link_color
    remove_column :accounts, :style_text_color
  end
end
