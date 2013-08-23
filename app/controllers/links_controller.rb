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

      if @thumb && @thumb.image
        @link.thumbnail = @thumb.image
      elsif @thumb && @thumb.images
        @link.thumbnail = @thumb.images.first.source_url
      else
        @link.thumbnail = "no_image"
      end
      @link.user = current_user

    # raise @link.inspect
      if @link.save
        websocket[current_user.id.to_s.to_sym].trigger 'new',{id: @link.id, type: @link.type, caption: @link.caption, link_url: @link.url ,link_thumb: @link.thumbnail}
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
