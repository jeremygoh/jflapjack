class FollowsController < ApplicationController
	def follow_by_comment
      
      if current_user
          possible_follower = Comment.find(params[:id]).user
          render :json => {already_following: current_user.is_being_followed?(possible_follower)}
          current_user.follow_user_by_comment(params[:id])
      end

	end

  def unfollow_by_comment
      
      if current_user
          following = Comment.find(params[:id]).user
          current_user.unfollow!(following)
          current_user.save
      end

  end

  def user_id_from_comment_id
      if current_user
        user_id = Comment.find(params[:id]).user.id
        render :json => {user_id: user_id}.to_json
      end
  end

   def user_is_followed
    if current_user
        user = User.find(params[:id])
        if user == current_user
          is_followed = -1 
        elsif current_user.following?(user)
          is_followed = 1
        else
          is_followed = 0
        end
    else
      is_followed = -2 #not logged in
    end
     render :json => is_followed.to_json
  end

end
