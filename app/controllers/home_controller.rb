class HomeController < ApplicationController
  def index
    @notifications = Notification.scoped_by_private_content(false).paginate :page => params[:page], :per_page => 10
  end
  
  def about
  end
end
