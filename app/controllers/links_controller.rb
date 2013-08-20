class LinksController < ApplicationController

before_action :redirect_if_not_signed_in

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link].permit(:caption, :url))
    @note.user = current_user
    if @link.save
      redirect_to '/'
    else
      render "new"
    end
  end

end
