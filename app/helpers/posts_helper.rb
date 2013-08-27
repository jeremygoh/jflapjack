module PostsHelper
	def get_size_multiplier(post)
  	(seconds_to_end(post) * 0.000011574).round(3)
  end

  def seconds_to_end(post)
  	if post != nil
  		(post.created_at + post.time) - Time.now 
  	end
  end

  def get_top_five_users_posts
  	@top_users = User.order( "comments_count desc" ).limit(5)
  	@top_posts = []
  	@top_users.each do |user|
  	  	@top_posts << user.posts if user.posts.length > 0
  	end
  	@top_posts
  end

  
end


