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

      if @link.save
        websocket[current_user.id.to_s.to_sym].trigger 'new', @link.to_json(only: [:id, :type, :caption, :url, :thumbnail, :user_id])
        redirect_to '/'
        flash[:notice] = "Successfully added a link."
      else
        render "new"
      end

    rescue SocketError
      flash[:alert] = "Invalid URL"
      render 'new'
    end

  end

end
