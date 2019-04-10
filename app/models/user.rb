class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	validates :sid, uniqueness: true
	validates :first, :last, :email, :sid, presence: true
  validate :correct_access_code

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/


  @@registration_code = "Michael"
  @@admin_code = ENV["ADMIN_CODE"]

  def correct_access_code
    if self.code != @@registration_code && self.code != @@admin_code
      errors.add(:code, "-- Wrong access code")
    end
  end

  def admin?
    self.code == @@admin_code
  end

  @member_only = ["first", "last", "team"]
  @admin_only = ["first", "last", "email", "team"]

  def self.search(search)
    if !search.blank?
      if !search.strip.include? " "
        # if member -- currently the only option
        @results = [] | 
          User.where("lower(first) = lower(?)", "#{search}").order(:first) |
          User.where("lower(last) = lower(?)", "#{search}").order(:first) |
          User.where("lower(team) = lower(?)", "#{search}").order(:first)
      else
        # split search string for full name search exact match or backwards
        search = search.split(" ")
        @results = (User.where("lower(first) = lower(?)", "#{search[0]}") &
        User.where("lower(last) = lower(?)", "#{search[1]}")) |
        (User.where("lower(first) = lower(?)", "#{search[1]}") &
        User.where("lower(last) = lower(?)", "#{search[0]}"))
      end
    else
      all.order(:first)
    end
  end

end
