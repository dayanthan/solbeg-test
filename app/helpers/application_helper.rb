module ApplicationHelper

	def allowed?(user, curr_user)
		ProfilePolicy.new(user, curr_user).allowed?
	end
end
