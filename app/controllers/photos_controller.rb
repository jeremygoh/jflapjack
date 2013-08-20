class PhotosController < ApplicationController

    def show
        @photo = Photo.find(params[:id])
    end

    def new
        @photo = Photo.new
    end

    def create
        @photo = Photo.new(params[:photo].permit(:caption, :photo))
        if @photo.save
            if params[:photo].blank?
                redirect_to @photo
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
        # puts 'XXXCXXXFWXDGHQFSDJGASKJDGHAKSJDHKAJSDHKAJSHDKJASHDKJASHDKASHDKA'
        # puts params[:photo].inspect

        if !params[:photo].blank?
          flash[:notice] = "Successfully updated user."
          redirect_to @photo
        else
          render :action => "crop"
        end
      else
        render :action => 'edit'
      end
    end
end
