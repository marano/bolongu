class FriendshipsController < ApplicationController

  def create
    friend = Account.find(params[:friend_id])

    if friend?(current_account, friend)
      flash[:error] = 'Already friends'
      redirect_to account_index_path friend.login
    else
      @friendship = Friendship.new({ :account => current_account, :friend => friend})
      @friendship.save!
      flash[:notice] = "Started to follow #{@friendship.friend.name}"
      AccountMailer.deliver_follow_notification(@friendship, account_index_url(@friendship.account.login))
      redirect_to account_index_path friend.login
    end
  end
  
  def destroy
    friendship = current_account.friendships.find(params[:id])

    if friendship.destroy
      flash[:notice] = "Stoped to follow #{friendship.friend.name}"
      redirect_to account_index_path friendship.friend.login
    end
  end
end
