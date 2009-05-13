class TweetsController < ApplicationController
  
  def create
    options = {}
    
    unless params[:in_reply_to_status_id].blank?
      options.merge!({:in_reply_to_status_id => params[:in_reply_to_status_id]})
    end
    
    @tweet = Tweet.new(:body => params[:text], :options => options, :account => current_account)
    
    if @tweet.save!
      flash[:notice] = "Tweeted succefully!"
    else
      flash[:error] = "Something went wrong!"
    end
    
    redirect_to :back
  end
  
  def show
    @tweet = Tweet.find(params[:id])
  end
  
  def destroy
    @tweet = Tweet.find(params[:id])
    if @tweet.destroy
      flash[:notice] = 'Tweet was deleted!'
    else
      flash[:error] = 'Couldnt delete tweet!'
    end
    redirect_to account_index_path(current_account.login)
  end
end
