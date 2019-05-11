class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	validates :sid, uniqueness: true
	validates :first, :last, :email, :sid, presence: true
  validate :correct_access_code


  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100#" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
    validates_attachment_size :image, :less_than => 5.megabytes

  belongs_to :team

  scope :search_team_name, lambda { |search|
    joins(:team).where("lower(name) LIKE lower(?)", "%#{search}%").order(:first)}



  ##Custom Validation methods
  def correct_access_code
    if self.code != Code.regular_code && self.code != Code.admin_code
      errors.add(:code, "-- Wrong access code")
    end
  end

  ##Methods dealing with user images
  def picture_missing?
    self.image.url.include?("missing.png")
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
  @@member = ["first", "last", "team", "major", "skillset", "year"]
  @@admin_only = ["email", "sid", "code"]

  # Search by keyword, phrase or alphabetically order by first name by default
  def search(search, admin)
    if !search.blank?
      @results = []
      if !search.strip.include? " "
        @results = self.search_keyword(search, admin)
      else
        @results = self.search_phrase(search, admin)
      end
    end
  end

  # Search keyword within respective member or admin fields
  def search_keyword(search, admin)
    permissions = admin ? @@member + @@admin_only : @@member
    @results = []

    for col in permissions
      self.update_results(col, search)
    end
    @results
  end

  # Search for a phrase within respective member or admin fields
  def search_phrase(search, admin)
    search = search.split(" ")
    permissions = admin ? @@member + @@admin_only : @@member
    @results = []

    for col in permissions
      for word in search
        self.update_results(col, word)
      end
    end
    @results
  end

  #generalize updating @results for search
  def update_results(column, search)
    if column == "team"
      find = User.search_team_name(search)
    else
      find = User.where("lower(#{column}) LIKE lower(?)", "%#{search}%").order(:first)
    end

    @results = @results | find
  end

  ##Methods dealing with download-roster
  def access
    self.admin? ? "admin" : "regular"
  end

  ##methods dealing with teams

  #for calling in index.html and other views
  def team_name
    self.team == nil ? "" : self.team.name
  end

  def is_member_of(team)
    return self.team == team
  end

  def is_leader_of(team)
    return team.leader == self
  end

  def has_a_team
    return self.team != nil
  end

  def is_a_leader
    return self.team != nil && self.team.leader == self
  end
end
