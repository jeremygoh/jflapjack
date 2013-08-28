module VideosHelper

	def youtube_thumb_url(url, num)
		regex = /^(?:http:\/\/)?(?:www\.)?\w*\.\w*\/(?:watch\?v=)?((?:p\/)?[\w\-]+)/
		youtube_thumb_url="http://img.youtube.com/vi/" + url.match(regex)[1] + "/" + num.to_s + ".jpg"
	end
end
