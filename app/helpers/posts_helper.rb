module PostsHelper
	def get_size_multiplier(post)
  	(seconds_to_end(post) * 0.000011574).round(3)
  end

  def seconds_to_end(post)
  	(post.created_at + post.time) - Time.now 
  end
end
