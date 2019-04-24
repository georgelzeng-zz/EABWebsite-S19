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

    User.where(code: old_code).update_all(code: newCode)
    Code.set_code(type, newCode)
    return Code.changed_successful_message(type, old_code, newCode)
  end

  ##Methods dealing with search
  @member = ["first", "last", "team"]
  @admin_only = ["email", "sid"]

  def self.search(search, admin)
    if !search.blank?
      @results = []
      if !search.strip.include? " "
        @results = self.search_keyword(search, admin)
      else
        @results = self.search_phrase(search, admin)
      end
    else
      all.order(:first)
    end
  end


  def self.search_keyword(search, admin)
    @permissions = admin ? @member.concat(@admin_only) : @member
    @results = []

    for col in @permissions
      @results = @results | User.where("lower(#{col}) LIKE lower(?)", "#{search}").order(:first) |
                 User.where("lower(#{col}) LIKE lower(?)", "%#{search}%").order(:first)
    end
    @results
  end


  def self.search_phrase(search, admin)
    search = search.split(" ")
    @permissions = admin ? @member.concat(@admin_only) : @member
    @results = []

    for col in @permissions
      for term in search
        @results = @results | User.where("lower(#{col}) = lower(?)", "#{term}").order(:first) |
                   User.where("lower(#{col}) = lower(?)", "%#{term}%").order(:first)
      end
    end
    @results
  end
end
