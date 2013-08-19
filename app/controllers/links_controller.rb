class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link].permit(:caption, :url))
    if @link.save
      redirect_to '/'
    else
      render "new"
    end
  end

end
