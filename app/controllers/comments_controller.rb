class CommentsController < ApplicationController

  def create
    comment = Comment.new(params[:comment].permit(:post_id, :body))
    comment.user = current_user
    if comment.save
      flash[:notice] = "Comment saved successfully"
    else
      flash[:alert] = "Failed to save comment"
    end

    redirect_to "/"

  end

end
