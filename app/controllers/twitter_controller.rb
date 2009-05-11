class TwitterController < ApplicationController

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
  end

end
