class PostsController < ApplicationController
  def new
    @link = Link.new
  end

  def create
  end

  def index
    @posts = Post.all
  end

  def show
  end

  def update
  end

  def destroy
  end
end
