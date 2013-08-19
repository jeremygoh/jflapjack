module PostsHelper
	def get_size_mulitplier(post)
  	(post.time * 0.000011574).round(3)
  end
end
