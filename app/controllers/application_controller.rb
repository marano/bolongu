# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem  

  helper :all
  helper_method :'friend?', :'current_account_content?'
  
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  rescue_from Twitter::TwitterError, :with => :twitter_unauthorized
  rescue_from Timeout::Error, :with => :timeout_error
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found_error
  rescue_from Exception, :with => :manage_error

  protected

    def current_account_content?(object)
      object.account == current_account
    end
    
    def account_from_path
      @account = Account.scoped_by_login(params[:account_login]).first
    end

    def friend?(account, friend)
      account.friendship(friend)
    end  
  
  private
  
    def twitter_unauthorized(exception)
      flash[:error] = 'A Twitter error has ocurred! ' + exception.message
      redirect_to :back
    end
    
    def timeout_error(exception)
      flash[:error] = 'You never got a response! ' + exception.message
      redirect_to :back
    end
    
    def not_found_error(exception)
      flash[:error] = 'What you seek couldnt be found! ' + exception.message
      redirect_to :back
    end
    
    def manage_error(exception)
      flash[:error] = 'Something went wrong! ' + exception.message
      redirect_to :back
    end
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  #não sei pra que serve!
  #session :session_key => '_authentication_session_id'
end
