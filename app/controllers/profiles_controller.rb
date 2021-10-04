class ProfilesController < ApplicationController
	before_action :authenticate_user!
	before_action :user_profile

	def show
		if policy.admin_edit_denied?
			flash[:alert] = "Unauthorized to access this profile."
			redirect_to :root
		end
	end

	def edit
		if policy.admin_edit_denied? || (current_user.admin? && @user.admin? && policy.edit_denied?)
			flash[:alert] = "Unauthorized to edit this profile."
			redirect_to :root
		end
	end

	def update
		if @user.profile.update(profile_params)
			flash[:notice] = "Profile updated successfully."
			redirect_to user_profile_path(@user, @user.profile)
		else
			flash[:alert] = @user.profile.errors.full_messages.join(', ')
			redirect_to edit_user_profile_path(@user, @user.profile)
		end
	end

	private
		def profile_params
			if current_user.admin?
				if policy.can_edit?		# admin and own profile so only certain filed(s) can update
					params.require(:profile).permit(:phone_no)
				elsif @user.admin?		# can't update other admin profile
					flash[:alert] = "Unauthorized to update this profile."
					redirect_to :root and return
				else
					require_params
				end
			elsif policy.can_edit?
				require_params
			else
				flash[:alert] = "Unauthorized to update this profile."
				redirect_to :root and return
			end
		end

		def require_params
			params.require(:profile).permit(:landmark, :street, :address, :phone_no, :state, :avatar, :city, :pincode)
		end

		def user_profile
			@user = User.includes(:profile).find(params[:user_id])
		end

		def policy
			ProfilePolicy.new(@user, current_user)
		end
end
