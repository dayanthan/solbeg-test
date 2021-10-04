class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		if current_user.admin?
			@users = User.includes(:profile).page(params[:page])
		else
			flash[:error] = "Unauthorized to access."
			redirect_to :root and return
		end
	end
end