class FollowsController < ApplicationController
	def follow_by_comment
      
      if current_user
          possible_follower = Comment.find(params[:id]).user
          render :json => {already_following: current_user.is_being_followed?(possible_follower)}
          current_user.follow_user_by_comment(params[:id])
      end

	end

  def user_id_from_comment_id
      if current_user
        user_id = Comment.find(params[:id]).user.id
        render :json => {user_id: user_id}.to_json
      end
  end

end
