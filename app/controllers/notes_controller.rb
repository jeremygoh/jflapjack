class NotesController < ApplicationController

before_action :redirect_if_not_signed_in

  def new
    @note = Note.new
  end

  def create
    
    @note = Note.new(params[:note].permit(:caption, :body))
    @note.user = current_user
    
    if @note.save
      websocket[current_user.id.to_s.to_sym].trigger 'new', @note.to_json(only: [:id, :type, :caption, :body])
      redirect_to '/'
      flash[:notice] = "Successfully added a note."
    else
      render "new"
    end
  
  end

end

