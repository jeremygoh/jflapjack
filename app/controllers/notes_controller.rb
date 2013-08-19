class NotesController < ApplicationController
  def new
    @note = Note.new
  end

  def create
    @note = Note.new(params[:note].permit(:caption, :body))
    if @note.save
      redirect_to '/'
    else
      render "new"
    end
  end
end
