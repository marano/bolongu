class CommentsController < ApplicationController

  def create
#    @post = Post.find(params[:post_id])
#    params[:comment][:account] = current_account
#    @comment = @post.comments.create!(params[:comment])    
    
    @comment = Comment.new(params[:comment])
    @comment.post_id = params[:post_id]    
    
    if logged_in?
      @comment.account = current_account
    end
    
    @comment.save!
    
    respond_to do |format|
      format.html { redirect_to @post}
      format.xml  { head :ok }
      format.js
    end
  end
  
  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(@post) }
      format.xml  { head :ok }
      format.js
    end
  end

#  # GET /comment
#  # GET /comments.xml
#  def index
#    @comments = Comment.find(:all)

#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @comments }
#    end
#  end

#  # GET /comments/1
#  # GET /comments/1.xml
#  def show
#    @comment = Comment.find(params[:id])

#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @comment }
#    end
#  end

#  # GET /comments/new
#  # GET /comments/new.xml
#  def new
#    @comment = Comment.new

#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @comment }
#    end
#  end

#  # GET /comments/1/edit
#  def edit
#    @comment = Comment.find(params[:id])
#  end

##  # POST /comments
##  # POST /comments.xml
##  def create
##    @comment = Comment.new(params[:comment])

##    respond_to do |format|
##      if @comment.save
##        flash[:notice] = 'Comment was successfully created.'
##        format.html { redirect_to(@comment) }
##        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
##      else
##        format.html { render :action => "new" }
##        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
##      end
##    end
##  end

#  # PUT /comments/1
#  # PUT /comments/1.xml
#  def update
#    @comment = Comment.find(params[:id])

#    respond_to do |format|
#      if @comment.update_attributes(params[:comment])
#        flash[:notice] = 'Comment was successfully updated.'
#        format.html { redirect_to(@comment) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

#  # DELETE /comments/1
#  # DELETE /comments/1.xml
#  def destroy
#    @comment = Comment.find(params[:id])
#    @comment.destroy

#    respond_to do |format|
#      format.html { redirect_to(comments_url) }
#      format.xml  { head :ok }
#    end
#  end
end
