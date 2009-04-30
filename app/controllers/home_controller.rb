class HomeController < ApplicationController
  def index
    @posts = Post.scoped_by_blog_private(false).all(:limit => 10)
  end
  
  def about
  end
end
