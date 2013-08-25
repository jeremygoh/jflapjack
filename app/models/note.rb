class Note < Post
	
	validates_presence_of :caption, :body
	validates_length_of :body,:maximum => 147

end