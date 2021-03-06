module PostsHelper

	def posts_reverse
		@posts.sort_by(&:created_at).reverse
	end

	def author
		@post.user.name
	end

	def author_options
		if signed_in?
			render partial: 'author_options' if current_user.name == author
		end
	end

	def comments_counter
		@post.comments.size
	end

end
