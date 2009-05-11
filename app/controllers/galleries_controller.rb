class GalleriesController < ApplicationController

  # GET /galleries
  # GET /galleries.xml
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
      @galleries = Gallery.paginate :page => params[:page], :per_page => 10
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @galleries }
    end
  end

  # GET /galleries/1
  # GET /galleries/1.xml
  def show
    @gallery = Gallery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gallery }
    end
  end

  # GET /galleries/new
  # GET /galleries/new.xml
  def new
    @gallery = Gallery.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gallery }
    end
  end

  # GET /galleries/1/edit
  def edit
    @gallery = Gallery.find(params[:id])
  end

  # POST /galleries
  # POST /galleries.xml
  def create
    @gallery = Gallery.new(params[:gallery])
    @gallery.account = current_account
    @gallery.should_tweet = params[:twitter]
    respond_to do |format|
      if @gallery.save
        flash[:notice] = 'Gallery was successfully created.'
        format.html { redirect_to @gallery }
        format.xml  { render :xml => @gallery, :status => :created, :location => @gallery }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /galleries/1
  # PUT /galleries/1.xml
  def update
    @gallery = Gallery.find(params[:id])

    respond_to do |format|
      if @gallery.update_attributes(params[:gallery])
        flash[:notice] = 'Gallery was successfully updated.'
        format.html { redirect_to @gallery }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.xml
  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy
    flash[:notice] = 'Gallery was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to(account_galleries_path(@gallery.account)) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def search_account
    @galleries = @account.galleries.paginate :page => params[:page], :per_page => 10
  end
  
  def search_all
    if @account.friend_ids.empty?
      search_account
    else
      @galleries = Gallery.paginate :conditions => "account_id = #{@account.id} OR (account_id IN (#{@account.friend_ids_as_string}) AND (blog_private = 'false' OR blog_private = 'f'))" , :page => params[:page], :per_page => 10   
    end
  end
  
  def search_network
    unless @account.friend_ids.empty?
      @galleries = Gallery.paginate :conditions => "account_id IN (#{@account.friend_ids_as_string}) AND (blog_private = 'false' OR blog_private = 'f')" , :page => params[:page], :per_page => 10
    else
      @galleries = Gallery.paginate :conditions => ['id=?', 0], :page => params[:page], :per_page => 10
    end
  end
end
