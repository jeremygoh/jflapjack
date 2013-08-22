class FollowsController < ApplicationController


	def follow_by_comment
			current_user.follow_by_comment(params[:id])
			redirect_to "/"
	end


end
