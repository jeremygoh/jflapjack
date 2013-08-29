include PostsHelper
class PostsController < ApplicationController
  
  def index

    # render text: "No posts" and return if current_

    @posts = []
    if current_user   
      @followed_users_ids_in_json = current_user.followed_users.pluck(:id).to_json
      followed_posts = current_user.followed_posts

      #check if there are any followed posts or that you have created a post 
      if !followed_posts.empty? || current_user.posts.size > 0 
        @posts = followed_posts 
        current_user.posts.each do |post|
            @posts << post
        end        # @posts = Post.followed_by(current_user).order("updated_at desc")
     
      else
        flash[:notice] = "These are the top 5 site users posts. Maybe follow 1 or 2 to get started..."
        get_top_five_users_posts.flatten.each do |post| #replace with top 5 users
          @posts << post
        end
        current_user.posts.each do |post|
          @posts << post
        end
      end
    else
        @posts = Post.find(:all, :order => "id desc")
    end


    @posts.keep_if{|post| get_size_multiplier(post) > 0.3 } unless @posts.empty?      ###!!!!!!THIS CONTROLS WHETHER A POST IS DISPLAYED BASED ON SIZE!!!!!!!
    
    @last_comments = Comment.find(:all, :order => "created_at desc", :limit => 10).reverse
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
      render :json => Post.find(params[:id]).comments(:order => "created_at asc", :limit => 5).reverse
  end

end
