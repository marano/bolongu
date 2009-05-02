class HomeController < ApplicationController
  def index
    @posts = Post.scoped_by_blog_private(false).all.paginate :page => params[:page], :per_page => 10
  end
  
  def about
  end
end
