class User < ApplicationRecord
	## keep the default scope first (if any)
	## constants come up next
	## enums after attr macros, prefer the hash syntax
	enum role: { regular: 0, admin: 1}
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :registerable, :validatable # , :recoverable, :rememberable

	## association macros
	has_one :profile, dependent: :destroy

	accepts_nested_attributes_for :profile

	## validation macros
	validates :name, :email, length: { maximum: 255 }, allow_blank: false

	## callbacks

  	## Methods
  	private

  	protected

  	public
end