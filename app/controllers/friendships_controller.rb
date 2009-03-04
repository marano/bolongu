class FriendshipsController < ApplicationController

  def create
    friend = Account.find(params[:friend_id])

    if friend?(current_account, friend)
      flash[:error] = 'Already friends'
      redirect_to account_index_path friend.login
    else
      friendship = Friendship.new({ :account => current_account, :friend => friend})
      friendship.save

      redirect_to account_index_path friend.login
    end
  end
end
