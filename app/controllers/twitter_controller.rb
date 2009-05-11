class TwitterController < ApplicationController

  def authorize
    oauth = current_account.twitter_oauth
    
    session['rtoken'] = oauth.request_token.token
    session['rsecret'] = oauth.request_token.secret
    
    redirect_to oauth.request_token.authorize_url
  end
  
  def show
    oauth = current_account.twitter_oauth
    oauth.authorize_from_request(session['rtoken'], session['rsecret'])
    
    session['rtoken'] = nil
    session['rsecret'] = nil
    
    current_account.update_attributes({
      :twitter_token => oauth.access_token.token, 
      :twitter_secret => oauth.access_token.secret,
    })
    
    redirect_to root_path
  end

end
