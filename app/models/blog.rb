class Blog < ApplicationRecord
  has_many :blog_permissions, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
end
