class NotesController < ApplicationController
  def new
    @note = Note.new
  end

  def create
    @note = Note.new(params[:note].permit(:caption, :body))
    @note.save
    redirect_to '/'
  end
end
