class Profile < ApplicationRecord
	mount_uploader :avatar, AvatarUploader

	## keep the default scope first (if any)
	## constants come up next
	## enums after attr macros, prefer the hash syntax

	## association macros
  	belongs_to :user

	## validation macros
	validates :user, :avatar, presence: true
	validates :landmark, :street, :address, :city, :state, length: { maximum: 255 }, allow_blank: false
	validates :pincode, numericality: { only_integer: true }
	validates :pincode, length: {is: 6, message: "must be 6 digit long"}, allow_blank: false  # Not allowed empty string or nil
	validate :avatar_validation, if: :avatar?
	validates_length_of :phone_no, minimum: 3, maximum: 15, allow_blank: true

	## callbacks

  	## Methods
  	private

  	protected
		def avatar_validation
	    	if avatar.size > 1.megabytes
	      		errors.add(:base, "picture should be less than 1MB")
	    	end
	 	end

  	public

end
