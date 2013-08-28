class VideosController < ApplicationController
  before_action :redirect_if_not_signed_in
  def new
  	@video = Video.new
  end

  def create
		@video = Video.new(params[:video].permit(:caption, :video, :youtube_url))
    @video.user = current_user
    if @video.save
      websocket[current_user.id.to_s.to_sym].trigger 'new', @video.to_json(only: [:id, :type, :caption, :youtube_url])
      redirect_to '/'
      flash[:notice] = "Successfully added a video link."
    else
      render "new"
    end
    rescue SocketError
      flash[:alert] = "Invalid URL"
      render 'new'
  end
  
end

