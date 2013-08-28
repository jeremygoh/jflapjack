class CommentsController < ApplicationController
  before_action :redirect_if_not_signed_in

  def create
    comment = Comment.new(params[:comment].permit(:post_id, :body))
    comment.user = current_user
    
    if comment.save
      ##INCREASE THE SIZE OF THE POST BY 30 MIN
      @post = Post.find(comment.post_id)
      @post.time += 3600 if @post.time > 100000
      @post.save
      puts @post.time.inspect
      websocket[:comment].trigger 'new',{post_id: comment.post.id, id: comment.id, body: comment.body, user: comment.user.id}
      flash[:alert] = "New commment added."
     else
      flash[:alert] = "Failed to save comment"
    end

    redirect_to "/"

  end


end
