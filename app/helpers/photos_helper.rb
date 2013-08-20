require 'debugger'

module PhotosHelper
end

module Paperclip
  class Cropper < Thumbnail
    def transformation_command
      if crop_command
        commands = super

        commands.delete_if { |command| command.include? 'crop' }
        [crop_command] + commands
      else
        super
      end
    end
    
    def crop_command
      target = @attachment.instance
      if target.cropping?
        # debugger
        " -crop '#{target.crop_w.to_i}x#{target.crop_h.to_i}+#{target.crop_x.to_i}+#{target.crop_y.to_i}'"
      end
    end
  end
end