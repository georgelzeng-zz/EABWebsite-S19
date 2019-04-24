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

  ##Custom Validation methods
  def correct_access_code
    if self.code != Code.regular_code && self.code != Code.admin_code
      errors.add(:code, "-- Wrong access code")
    end
  end

  ##Methods dealing with access codes

  #to tell whether a user is an admin
  def admin?
    self.code == Code.admin_code
  end

  #to change an access code, as well as current members' access code (if having corresponding code)
  def self.change_code(type, newCode)
    old_code = Code.get_code(type)

    if newCode == old_code
      return Code.changing_to_same_value(type, newCode)
    end

    Code.set_code(type, newCode)
    User.where(code: old_code).update_all(code: newCode)
    
    return Code.changed_successful_message(type, old_code, newCode)
  end

  ##Methods dealing with search
  @member = ["first", "last", "team"]
  @admin_only = ["email", "sid"]

  def self.search(search, admin)
    if !search.blank?
      @results = []
      if !search.strip.include? " "
        @results = self.search_singular(search, admin)
      else
        @results = self.search_phrase(search, admin)
      end
    else
      all.order(:first)
    end
  end

  def self.search_singular(search, admin)
    @access, @results = [], []
    if admin
      for col in @admin_only
        @access = @access | User.where("#{col} = lower(?)", "#{search}").order(:first)
      end
    end

    for col in @member
      @results = @results | User.where("lower(#{col}) = lower(?)", "#{search}").order(:first)
    end

    @results = @results | @access
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

  ##Methods dealing with download-roster

  def to_XML
    User.column_names.each do |
  end
end
