class Statistic < ApplicationRecord
	belongs_to :post
	has_many :ips, :dependent => :destroy
end
