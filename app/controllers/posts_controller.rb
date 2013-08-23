class PostsController < ApplicationController
  
  def index
    if current_user   
      @followed_users_ids_in_json = current_user.followers.ids.to_json
      if !Post.followed_by(current_user).empty?
        @posts = Post.followed_by(current_user)
      else
        @posts = Post.find(:all, :order => "id desc")
      end
    else
        @posts = Post.find(:all, :order => "id desc")
    end
    @last_comments = Comment.find(:all, :order => "id desc", :limit => 10).reverse
 
  end

  def show
    @post = Post.find(params[:id])
    render layout: nil
  end

  def update
  end

  def destroy
  end


end
