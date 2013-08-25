class PostsController < ApplicationController
  
  def index
    if current_user   
      @followed_users_ids_in_json = current_user.followers.ids.to_json
      if !Post.followed_by(current_user).empty?
        @posts = Post.followed_by(current_user)
      else
        @posts = Post.find(:all, :order => "id desc") #replace with top 5 users
      end
    else
        @posts = Post.find(:all, :order => "id desc")
    end
    @posts.keep_if{|post| get_size_multiplier(post) > 0.3 }       ###!!!!!!THIS CONTROLS WHETHER A POST IS DISPLAYED!!!!!!!
    @last_comments = Comment.find(:all, :order => "created_at desc", :limit => 10)
 
  end

  def show
    @post = Post.find(params[:id])
    render layout: nil
  end

  def update
  end

  def destroy
  end

  def last_five_from_user
      render :json => User.find(params[:id]).posts(:order => "created_at desc", :limit => 5).to_json(:only=> [:id, :type, :caption, :body, :url, :thumbnail], :methods => [:photo_url])
  end

end
