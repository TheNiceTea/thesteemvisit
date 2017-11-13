class Post < ApplicationRecord
	has_attached_file :image, styles: { default: "728x90>" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	acts_as_votable
	belongs_to :user
	belongs_to :category
	has_many :statistics, :dependent => :destroy
	is_impressionable
end
