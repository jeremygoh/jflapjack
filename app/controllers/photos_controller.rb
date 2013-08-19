class PhotosController < ApplicationController

    def new
        @photo = Photo.new
    end

    def create
        @photo = Photo.new(params[:photo].permit(:caption, :photo))
        if @photo.save
          redirect_to "/"
        else
          render "new"
        end
    end

end
