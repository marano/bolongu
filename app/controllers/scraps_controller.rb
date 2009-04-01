class ScrapsController < ApplicationController

  before_filter :login_required, :fetch_account

  def index
    @scraps = @account.scraps
    
    @scraps.each { |s| s.update_attribute :read, true }
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @scraps }
    end
  end

  #  # GET /scraps/1
  #  # GET /scraps/1.xml
  #  def show
  #    @scrap = @account.scraps.find(params[:id])

  #    respond_to do |format|
  #      format.html # show.html.erb
  #      format.xml  { render :xml => @scrap }
  #    end
  #  end

  #  # GET /scraps/new
  #  # GET /scraps/new.xml
  #  def new
  #    @scrap = @account.scraps.build

  #    respond_to do |format|
  #      format.html # new.html.erb
  #      format.xml  { render :xml => @scrap }
  #    end
  #  end

  #  # GET /scraps/1/edit
  #  def edit
  #    @scrap = account.scraps.find(params[:id])
  #  end

  # POST /scraps
  # POST /scraps.xml
  def create
    @scrap = @account.scraps.build(params[:scrap])
    @scrap.author = current_account
    
    respond_to do |format|
      if @scrap.save
        #flash[:notice] = 'Scrap was successfully created.'
        format.html { redirect_to account_scraps_path(@account) }
        format.xml  { render :xml => @scrap, :status => :created, :location => @scrap }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @scrap.errors, :status => :unprocessable_entity }
      end
    end
  end

  #  # PUT /scraps/1
  #  # PUT /scraps/1.xml
  #  def update
  #    @scrap = Scrap.find(params[:id])

  #    respond_to do |format|
  #      if @scrap.update_attributes(params[:scrap])
  #        flash[:notice] = 'Scrap was successfully updated.'
  #        format.html { redirect_to(@scrap) }
  #        format.xml  { head :ok }
  #      else
  #        format.html { render :action => "edit" }
  #        format.xml  { render :xml => @scrap.errors, :status => :unprocessable_entity }
  #      end
  #    end
  #  end

  # DELETE /scraps/1
  # DELETE /scraps/1.xml
  def destroy
    @scrap = @account.scraps.find(params[:id])
    @scrap.destroy

    respond_to do |format|
      format.html { redirect_to account_scraps_path(@account) }
      format.xml  { head :ok }
      format.js
    end
  end

  private

  def fetch_account
    unless params[:account_id].blank?
      @account = Account.find(params[:account_id])
    end
  end

end

