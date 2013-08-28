include PostsHelper
class PostsController < ApplicationController
  
  def index
    @posts = []
    if current_user   
      @followed_users_ids_in_json = current_user.followers.ids.to_json
      if !Post.followed_by(current_user).empty?
        @posts = Post.followed_by(current_user).order("updated_at desc")
      else
        flash[:notice] = "These are the top 5 site users posts. Maybe follow 1 or 2 to get started..."
        get_top_five_users_posts.flatten.each do |post| #replace with top 5 users
          @posts << post
        end
      end
    else
        @posts = Post.find(:all, :order => "id desc")
    end
    @posts.keep_if{|post| get_size_multiplier(post) > 0.3 }       ###!!!!!!THIS CONTROLS WHETHER A POST IS DISPLAYED BASED ON SIZE!!!!!!!
    
    @last_comments = Comment.find(:all, :order => "created_at desc", :limit => 10)
  end

  def show
    @last_comments = Comment.find(:all, :order => "created_at desc", :limit => 10)
    
    @post = Post.find(params[:id])

    @last_post_comments = Post.find(params[:id]).comments.find(:all, :order => "created_at desc", :limit => 10)

    render layout: nil
  end

  def update
  end

  def destroy
  end

  def last_five_from_user
      render :json => User.find(params[:id]).posts(:order => "created_at desc", :limit => 5).to_json(
                                                                                                :methods => [:photo_url, :type])
  end

  def last_five_comments_for_post
      render :json => Post.find(params[:id]).comments(:order => "created_at asc", :limit => 5)
  end

end
