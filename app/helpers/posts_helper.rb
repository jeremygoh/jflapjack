module PostsHelper
	def get_size_multiplier(post)
  	(post.time * 0.000011574).round(3)
  end
end
