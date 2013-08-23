class CommentsController < ApplicationController
before_action :redirect_if_not_signed_in

  def create
    comment = Comment.new(params[:comment].permit(:post_id, :body))
    comment.user = current_user
    if comment.save
      # flash[:notice] = "Comment saved successfully"
      websocket[:comment].trigger 'new',{post_id: comment.post.id, id: comment.id, body: comment.body, user: comment.user.id}
     else
      flash[:alert] = "Failed to save comment"
    end

    redirect_to "/"

  end

end
