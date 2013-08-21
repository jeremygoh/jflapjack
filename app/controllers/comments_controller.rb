class CommentsController < ApplicationController
before_action :redirect_if_not_signed_in

  def create
    comment = Comment.new(params[:comment].permit(:post_id, :body))
    comment.user = current_user
    if comment.save
      flash[:notice] = "Comment saved successfully"
      WebsocketRails[:comments].trigger 'new',{id: comment.id, body: comment.body}
    else
      flash[:alert] = "Failed to save comment"
    end

    redirect_to "/"

  end

end
