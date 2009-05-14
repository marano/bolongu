class HomeController < ApplicationController
  def index
    @notifications = Notification.scoped_by_private_content(false).paginate :page => params[:page], :per_page => 10, :conditions => [ "notifiable_type NOT LIKE 'Tweet'" ]
    @tweets = Tweet.scoped_by_blog_private(false).paginate :page => params[:page], :per_page => 30
  end
  
  def about
  end
end
