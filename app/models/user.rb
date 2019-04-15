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


  @@registration_code = ENV["ACCESS_CODE"]
  @@admin_code = ENV["ADMIN_CODE"]

  def self.registration_code
    @@registration_code
  end

  def self.admin_code
    @@admin_code
  end

  def correct_access_code
    if self.code != @@registration_code && self.code != @@admin_code
      errors.add(:code, "-- Wrong access code")
    end
  end

  def admin?
    self.code == @@admin_code
  end

  @member = ["first", "last", "team"]
  @admin_only = ["email", "sid"]

  def self.search(search, admin)
    if !search.blank?
      @access, @results = [], []
      if !search.strip.include? " "
        if admin
          for col in @admin_only
            @access = @access | User.where("#{col} = lower(?)", "#{search}").order(:first)
          end
        end

        for col in @member
          @results = @results | User.where("lower(#{col}) = lower(?)", "#{search}").order(:first)
        end

        @results = @results | @access
      else
        @results = self.search_phrase(search, admin)
      end
    else
      all.order(:first)
    end
  end

  def self.search_phrase(search, admin)
    search = search.split(" ")

    for col in @member
      for term in search
        @results = @results | User.where("lower(#{col}) = lower(?)", "#{term}").order(:first)
      end
    end
    @results
  end

end
