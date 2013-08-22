class VideosController < ApplicationController
  def new
  	@video = Video.new
  end

  def create
		@video = Video.new(params[:video].permit(:caption, :video, :youtube_url))
    @video.user = current_user
        if @video.save
          websocket[:main_socket].trigger 'post',{id: @video.id, type: @video.type, caption: @video.caption, youtube_url: @video.youtube_url }
          redirect_to '/'
        else
          render "new"
        end
  end
end
