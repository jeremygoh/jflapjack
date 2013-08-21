class LinksController < ApplicationController
include LinksHelper

before_action :redirect_if_not_signed_in

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link].permit(:caption, :url))
    
    begin    
      @thumb = LinkThumbnailer.generate(@link.url)

      if @thumb 
        @link.thumbnail = @thumb.image
      end
      @link.user = current_user

    # raise @link.inspect
      if @link.save
        redirect_to '/'
      else
        render "new"
      end

    rescue SocketError
      flash[:alert] = "Invalid URL"
      render 'new'
    end

  end
end

