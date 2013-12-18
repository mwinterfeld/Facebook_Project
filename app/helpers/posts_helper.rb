module PostsHelper

	def getFullname(username)
		user = User.find_by_username("#{username}")
		return string = User.first_name + " " + User.last_name
	end
end
