class ThingsController < ApplicationController

  def add
    @thing = Thing.find(params[:id])
    current_account.things << @thing
    flash[:notice] = "#{@thing.name} was added to your things."
    redirect_to :back
  end
  
  def remove
    @thing = Thing.find(params[:id])
    current_account.things.delete @thing
    flash[:notice] = "#{@thing.name} was removed from your things."
    redirect_to :back
  end
  
  # GET /things
  # GET /things.xml
  def index
    if params[:account_id]
      @account = Account.find(params[:account_id])
      @things = @account.things.paginate :page => params[:page], :per_page => 10
    else
      @things = Thing.paginate :page => params[:page], :per_page => 10
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @things }
    end
  end

  # GET /things/1
  # GET /things/1.xml
  def show
    @thing = Thing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @thing }
    end
  end

  # GET /things/new
  # GET /things/new.xml
  def new
    @thing = Thing.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @thing }
    end
  end

  # GET /things/1/edit
  def edit
    @thing = Thing.find(params[:id])
  end

  # POST /things
  # POST /things.xml
  def create
    @thing = Thing.new(params[:thing])
    @thing.author = current_account
    
    respond_to do |format|
      if @thing.save
        current_account.things << @thing
        
        flash[:notice] = 'Thing was successfully created.'
        format.html { redirect_to @thing }
        format.xml  { render :xml => @thing, :status => :created, :location => @thing }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @thing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /things/1
  # PUT /things/1.xml
  def update
    @thing = Thing.find(params[:id])

    params[:thing].delete :photo if params[:thing][:photo].nil?

    respond_to do |format|
      if @thing.update_attributes(params[:thing])
        flash[:notice] = "#{@thing.name} was updated."
        format.html { redirect_to(@thing) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /things/1
  # DELETE /things/1.xml
  def destroy
    @thing = Thing.find(params[:id])
    @thing.destroy
    flash[:notice] = "#{@thing.name} was deleted."
    respond_to do |format|
      format.html { redirect_to(things_url) }
      format.xml  { head :ok }
    end
  end
end
