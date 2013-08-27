class Photo < Post

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  validates_presence_of :caption, :photo, :type

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
    
  def photo_geometry(style = :original)
    @geometry ||= {}
    photo_path = (photo.options[:storage] == :s3) ? photo.url(style) : photo.path(style)
    @geometry[style] ||= Paperclip::Geometry.from_file(photo_path)
  end

  def photo_url
    if !self.cropped?
      self.photo.url(:square)
    else
      self.photo.url(:large)
    end
  end

  private

end