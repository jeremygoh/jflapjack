class PostsController < ApplicationController
  
  def index
    @posts = Post.find(:all, :order => "id desc")
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

