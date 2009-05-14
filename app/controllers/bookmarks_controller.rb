class BookmarksController < ApplicationController

  def reload_thumb
    @bookmark = Bookmark.find(params[:id])
    if Bookmark.fetch_thumbs!(@bookmark)
      flash[:notice] = 'Success!'
    else
      flash[:error] = 'Oh crap!'
    end
    redirect_to :back
  end

  # GET /bookmarks
  # GET /bookmarks.xml
  def index
    if params[:account_id]
      @account = Account.find(params[:account_id])
      @show = params[:show]
      case @show
      when 'account'
        search_account
      when 'all'
        search_all
      when 'network'
        search_network
      else
        if logged_in? and @account == current_account
          @show = 'all'
          search_all
        else
          @show = 'account'
          search_account
        end
      end
    else
      @bookmarks = Bookmark.paginate :page => params[:page], :per_page => 10
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookmarks }
    end
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.xml
  def show
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bookmark }
    end
  end

  # GET /bookmarks/new
  # GET /bookmarks/new.xml
  def new
    @bookmark = Bookmark.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bookmark }
    end
  end

  # GET /bookmarks/1/edit
  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  # POST /bookmarks
  # POST /bookmarks.xml
  def create
    @bookmark = Bookmark.new(params[:bookmark])
    @bookmark.publisher = current_account
    @bookmark.should_tweet = params[:twitter]
    
    respond_to do |format|
      if @bookmark.save
        flash[:notice] = 'Bookmark was successfully created.'
        format.html { redirect_to(@bookmark) }
        format.xml  { render :xml => @bookmark, :status => :created, :location => @bookmark }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bookmarks/1
  # PUT /bookmarks/1.xml
  def update
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      if @bookmark.update_attributes(params[:bookmark])
        flash[:notice] = 'Bookmark was successfully updated.'
        format.html { redirect_to(@bookmark) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.xml
  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def search_account
    @bookmarks = @account.bookmarks.paginate :page => params[:page], :per_page => 10
  end
  
  def search_all
    if @account.friend_ids.empty?
      search_account
    else
      @bookmarks = Bookmark.paginate :conditions => "publisher_id = #{@account.id} OR (publisher_id IN (#{@account.friend_ids_as_string}) AND (blog_private = 'false' OR blog_private = 'f'))" , :page => params[:page], :per_page => 10   
    end
  end
  
  def search_network
    unless @account.friend_ids.empty?
      @bookmarks = Bookmark.paginate :conditions => "publisher_id IN (#{@account.friend_ids_as_string}) AND (blog_private = 'false' OR blog_private = 'f')" , :page => params[:page], :per_page => 10
    else
      @bookmarks = Bookmark.paginate :conditions => ['id=?', 0], :page => params[:page], :per_page => 10
    end
  end
end
