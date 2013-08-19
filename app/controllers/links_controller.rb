class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link].permit(:caption, :url))
    @link.save
    redirect_to '/'
  end

end
