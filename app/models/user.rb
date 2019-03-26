class User < ActiveRecord::Base
	validates :sid, uniqueness: true
	validates :first, :last, :email, :sid, presence: true
end
