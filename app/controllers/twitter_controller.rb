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
    oauth = current_account.twitter_oauth
    oauth.authorize_from_request(session['rtoken'], session['rsecret'])
    
    session['rtoken'] = nil
    session['rsecret'] = nil
    
    current_account.update_attributes({
      :twitter_token => oauth.access_token.token, 
      :twitter_secret => oauth.access_token.secret,
      :twitter_active => true
    })
    
    flash[:notice] = 'Twitter is active!'
    redirect_to edit_account_path(current_account)
  end
  
  def deactivate
    current_account.update_attributes({
      :twitter_token => nil,
      :twitter_secret => nil,
      :twitter_active => false
    })
    
    flash[:notice] = 'Twitter was deactived!'
    redirect_to edit_account_path(current_account)
  end
  
  def show_tweet
    @tweet = current_account.client.status(params[:id])
  end
  
  def fav
    flash[:notice] = "Tweet fav'd. May not show up right away due to API latency."
    current_user.client.favorite_create(params[:id])
    return_to :back
  end
  
  def unfav
    flash[:notice] = "Tweet unfav'd. May not show up right away due to API latency."
    current_user.client.favorite_destroy(params[:id])
    return_to :back
  end

end
