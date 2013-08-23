class VideosController < ApplicationController
  def new
  	@video = Video.new
  end

  def create
		@video = Video.new(params[:video].permit(:caption, :video, :youtube_url))
    @video.user = current_user
        if @video.save
          websocket[current_user.id.to_s.to_sym].trigger 'new',{id: @video.id, type: @video.type, caption: @video.caption, youtube_url: @video.youtube_url }
          redirect_to '/'
        else
          render "new"
        end
  end
end
