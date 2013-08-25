class Photo < Post

attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

validates_presence_of :caption, :photo, :type


after_update :reprocess_photo, :if => :cropping?
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  # def photo_geometry(style = :original)
  #   @geometry ||= {}
  #   @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  # end
  
  def photo_geometry(style = :original)
    @geometry ||= {}
    photo_path = (photo.options[:storage] == :s3) ? photo.url(style) : photo.path(style)
    @geometry[style] ||= Paperclip::Geometry.from_file(photo_path)
  end

  def photo_url
    self.photo.url(:large)
  end

  private
  
  def reprocess_photo
    photo.reprocess!
  end


end