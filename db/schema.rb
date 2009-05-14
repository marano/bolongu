# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090514172700) do

  create_table "accounts", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "blog_title"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.time     "last_login"
    t.text     "bio"
    t.boolean  "twitter_active",                           :default => false
    t.string   "twitter_token"
    t.string   "twitter_secret"
  end

  add_index "accounts", ["login"], :name => "index_accounts_on_login", :unique => true

  create_table "accounts_things", :id => false, :force => true do |t|
    t.integer "account_id"
    t.integer "thing_id"
  end

  create_table "bookmarks", :force => true do |t|
    t.string   "title"
    t.string   "adress"
    t.text     "description"
    t.integer  "publisher_id"
    t.boolean  "blog_private",                :default => false
    t.string   "cached_tag_list"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "screen_file_name"
    t.string   "screen_content_type"
    t.integer  "screen_file_size"
    t.datetime "screen_updated_at"
    t.string   "screen_excerpt_file_name"
    t.string   "screen_excerpt_content_type"
    t.integer  "screen_excerpt_file_size"
    t.datetime "screen_excerpt_updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
    t.string   "name"
    t.string   "email"
    t.string   "url"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.boolean  "read",             :default => false
  end

  create_table "friendships", :force => true do |t|
    t.integer  "account_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "blog_private",    :default => false
    t.string   "cached_tag_list"
  end

  create_table "gallery_photos", :force => true do |t|
    t.string   "name"
    t.text     "caption"
    t.integer  "gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "cover"
    t.integer  "publisher_id"
    t.integer  "position"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "published_at"
    t.integer  "publisher_id"
    t.boolean  "private_content", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cached_tag_list"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.integer  "author_id"
    t.boolean  "blog_private",       :default => false
    t.string   "cached_tag_list"
  end

  create_table "scraps", :force => true do |t|
    t.text     "body"
    t.integer  "author_id"
    t.integer  "recipient_id"
    t.boolean  "read",         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "things", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "author_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.boolean  "blog_private",            :default => false
    t.string   "cached_tag_list"
  end

  create_table "tweets", :force => true do |t|
    t.string   "body"
    t.integer  "tweetable_id"
    t.string   "tweetable_type"
    t.integer  "account_id"
    t.integer  "twitter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "blog_private",    :default => false
    t.string   "cached_tag_list"
  end

end
