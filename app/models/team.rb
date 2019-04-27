class Team < ActiveRecord::Base
  validates :name, uniqueness: true
	validates :name, :password, presence: true

  belongs_to :leader, :class_name => "User", :foreign_key => "user_id"
  has_many :members, :class_name => "User"

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_attachment_size :image, :less_than => 5.megabytes
end
