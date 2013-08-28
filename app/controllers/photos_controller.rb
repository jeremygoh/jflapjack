class PhotosController < ApplicationController

before_action :redirect_if_not_signed_in

    def show
        @photo = Photo.find(params[:id])
    end

    def new
        @photo = Photo.new
    end

    def create
        @photo = Photo.new(params[:photo].permit(:caption, :photo))
        @photo.user = current_user
        if @photo.save
          # websocket[current_user.id.to_s.to_sym].trigger 'new', @photo.to_json(only: [:id, :type, :caption], :methods => [:photo_url])
          #websocket[current_user.id.to_s.to_sym].trigger 'new',{id: @photo.id, type: @photo.type, caption: @photo.caption, photo_url: @photo.photo.url(:large) }
            if params[:photo].blank?
                redirect_to '/'
            else
                render "crop"
            end
        else
          render "new"
        end
    end

    def update
      @photo = Photo.find(params[:id])
      if @photo.update_attributes(params[:photo].permit(:crop_x,:crop_y,:crop_w,:crop_h))
        if !params[:photo].blank?
          @photo.photo.reprocess!(:large)
          @photo.cropped = true
          @photo.save
          websocket[current_user.id.to_s.to_sym].trigger 'new', @photo.to_json(only: [:id, :type, :caption], :methods => [:photo_url])
          flash[:notice] = "Successfully added a photo."
          redirect_to '/'
        else
          render :action => "crop"
        end
      else
        render :action => 'edit'
      end
    end
end



