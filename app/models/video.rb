class Video < Post
	validates_presence_of :caption, :youtube_url, :type


end