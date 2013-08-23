class FollowsController < ApplicationController
	def follow_by_comment
      puts "1234 #{params[:id]}"
      puts current_user.inspect
			current_user.follow_user_by_comment(params[:id]) if current_user
	end

  def user_id_from_comment_id

      user_id = Comment.find(params[:id]).user.id
      render :json => {user_id: user_id}.to_json
  end

end
