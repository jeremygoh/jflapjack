module VideosHelper

	def youtube_thumb_url(url, num)
		# http://www.youtube.com/watch?v=_eeFb8skrV0
		# http://img.youtube.com/vi/_eeFb8skrV0/1.jpg
		regex = /^(?:http:\/\/)?(?:www\.)?\w*\.\w*\/(?:watch\?v=)?((?:p\/)?[\w\-]+)/
		youtube_thumb_url="http://img.youtube.com/vi/" + url.match(regex)[1] + "/" + num.to_s + ".jpg"
	end
end
