class TwitterController < ApplicationController

  def account_blog    
    @account = Account.find(params[:account_id])
    params[:page] ||= 1
    @tweets = @account.twitter_client.friends_timeline(:page => params[:page])
    render 'blog'
  end
  
  def blog    
    @tweets = current_account.twitter_client.user_timeline(:id => params[:id])
    @user = current_account.twitter_client.user(params[:id])
    render 'blog'
  end

  def activate
    oauth = current_account.twitter_oauth
    
    session['rtoken'] = oauth.request_token.token
    session['rsecret'] = oauth.request_token.secret
    
    redirect_to oauth.request_token.authorize_url
  end
  
  def authorized
    params[:oauth_token]
    
    begin
      oauth = current_account.twitter_oauth
      oauth.authorize_from_request(session['rtoken'], session['rsecret'])
      
      session['rtoken'] = nil
      session['rsecret'] = nil
      
      atoken = oauth.access_token.token
      asecret = oauth.access_token.secret
      
      set_account_twitter_settings(atoken, asecret, true)
      
      flash[:notice] = 'Twitter is active!'    
    rescue => e
      disable_twitter
      
      flash[:error] = 'Something went wrong!'
    end
    
    redirect_to edit_account_path(current_account)
  end
  
  def deactivate
    disable_twitter
    
    flash[:notice] = 'Twitter was deactived!'
    redirect_to edit_account_path(current_account)
  end
  
  def show
    @tweet = current_account.twitter_client.status(params[:id])
  end
  
  def fav
    begin
      flash[:notice] = "Tweet fav'd! May not show up right away due to API latency."
      current_account.twitter_client.favorite_create(params[:id])
    rescue => e
      flash[:notice] = "Something went wrong!"
    end
    redirect_to :back
  end
  
  def unfav
    begin
      flash[:notice] = "Tweet unfav'd! May not show up right away due to API latency."
      current_account.twitter_client.favorite_destroy(params[:id])
    rescue => e
      flash[:notice] = "Something went wrong!"
    end
    redirect_to :back
  end
  
  private
  
  def disable_twitter
    set_account_twitter_settings('', '', false) if current_account.twitter_active
  end
  
  def set_account_twitter_settings(atoken, asecret, active)
    current_account.update_attributes({
      :twitter_token => atoken,
      :twitter_secret => asecret,
      :twitter_active => active
    })
  end

end
