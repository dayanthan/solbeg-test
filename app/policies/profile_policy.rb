class ProfilePolicy
	def initialize(user, curr_user)
		@user = user
		@curr_user = curr_user
	end

	def allowed?
		!@user.admin? || (@user.admin? && can_edit?)
	end

	def can_edit?
		@user.id == @curr_user.id
	end

	def edit_denied?
		!can_edit?
	end

	def admin_edit_denied?
		!@curr_user.admin? && edit_denied?
	end

end
