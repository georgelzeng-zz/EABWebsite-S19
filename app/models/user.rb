class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	validates :sid, uniqueness: true
	validates :first, :last, :email, :sid, presence: true
  validate :correct_access_code
  @@registration_code = ENV["ACCESS_CODE"]
  @@admin_code = ENV["ADMIN_CODE"]

  def correct_access_code
    if self.code != @@registration_code && self.code != @@admin_code
      errors.add(:code, "-- Wrong access code")
    end
  end

  def admin?
    self.code == @@admin_code
  end

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
          User.where("lower(last) = lower(?)", "#{search[1]}") &
          User.where("lower(team) = lower(?)", "#{search[2]}")) |
          (User.where("lower(first) = lower(?)", "#{search[1]}") |
          User.where("lower(last) = lower(?)", "#{search[2]}") &
          User.where("lower(team) = lower(?)", "#{search[0]}")) |
          (User.where("lower(first) = lower(?)", "#{search[2]}") |
          User.where("lower(last) = lower(?)", "#{search[1]}") &
          User.where("lower(team) = lower(?)", "#{search[0]}"))
      end
    else
      all.order(:first)
    end
  end

end
