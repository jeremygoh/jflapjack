class NotesController < ApplicationController

before_action :redirect_if_not_signed_in

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(params[:note].permit(:caption, :body))
    @note.user = current_user
    if @note.save
      websocket[:main_socket].trigger 'post',{id: @note.id, type: @note.type, caption: @note.caption, note_body: @note.body }
      redirect_to '/'
    else
      render "new"
    end
  end
end

