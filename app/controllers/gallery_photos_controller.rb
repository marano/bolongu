class GalleryPhotosController < ApplicationController

  # fix for swfupload
  # session :cookie_only => false, :only => :create

  def sort
    if logged_in? and current_account == GalleryPhoto.find(params[:gallery_photos][0]).gallery.account
      params[:gallery_photos].each_with_index do |id, index|
        GalleryPhoto.update_all(['position = ?', index + 1], ['id = ?', id])
      end
    end
    render :nothing => true
  end

#  # GET /gallery_photos
#  # GET /gallery_photos.xml
#  def index
#    @gallery_photos = GalleryPhoto.all

#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @gallery_photos }
#    end
#  end

  # GET /gallery_photos/1
  # GET /gallery_photos/1.xml
  def show
    if params[:page]
      @gallery_photo = GalleryPhoto.find params[:id]
      @gallery_photos = @gallery_photo.gallery.gallery_photos.paginate :page => params[:page], :per_page => 1
      @gallery_photo = @gallery_photos[0]
    else
      @gallery_photo = GalleryPhoto.find params[:id]
      @gallery_photos = @gallery_photo.gallery.gallery_photos.paginate :page => (@gallery_photo.gallery.gallery_photos.index(@gallery_photo) + 1), :per_page => 1
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gallery_photo }
    end
  end

#  # GET /gallery_photos/new
#  # GET /gallery_photos/new.xml
#  def new
#    @gallery_photo = GalleryPhoto.new

#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @gallery_photo }
#    end
#  end

  # GET /gallery_photos/1/edit
  def edit
    @gallery_photo = GalleryPhoto.find(params[:id])
  end

  # POST /gallery_photos
  # POST /gallery_photos.xml
  def create
    @gallery_photo = GalleryPhoto.new(params[:gallery_photo])
    
    @gallery_photo.publisher = current_account
    
    respond_to do |format|
      if @gallery_photo.save
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to(account_gallery_path(@gallery_photo.gallery.account, @gallery_photo.gallery)) }
        format.xml  { render :xml => @gallery_photo, :status => :created, :location => @gallery_photo }
      else
        flash[:gallery_photo] = @gallery_photo
        flash[:error] = 'Photo couldnt be created :('        
        format.html { redirect_to [@gallery_photo.gallery.account, @gallery_photo.gallery] }
        format.xml  { render :xml => @gallery_photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /gallery_photos/1
  # PUT /gallery_photos/1.xml
  def update
    @gallery_photo = GalleryPhoto.find(params[:id])

    respond_to do |format|
      if @gallery_photo.update_attributes(params[:gallery_photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to(@gallery_photo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gallery_photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gallery_photos/1
  # DELETE /gallery_photos/1.xml
  def destroy
    @gallery_photo = GalleryPhoto.find(params[:id])
    @gallery_photo.destroy
    flash[:notice] = 'Photo was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to(account_gallery_path(@gallery_photo.gallery.account, @gallery_photo.gallery)) }
      format.xml  { head :ok }
    end
  end
end
