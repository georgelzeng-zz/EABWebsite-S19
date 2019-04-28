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
    validates_attachment_size :image, :less_than => 5.megabytes

  belongs_to :team

  scope :search_team_name, lambda { |search|
    joins(:team).where("lower(name) LIKE lower(?)", "%#{search}%").order(:first)}

  @@roster_file_name = "EAB_roster.xml"
  @@roster_file_directory = Rails.root.to_s
  @@full_file_path = File.join(@@roster_file_directory, @@roster_file_name)

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
  @@member = ["first", "last", "team", "major", "skillset", "linkedinLstring", "facebook", "year"]
  @@admin_only = ["email", "sid", "code"]

  # Search by keyword, phrase or alphabetically order by first name by default
  def self.search(search, admin)
    if !search.blank?
      @@results = []
      if !search.strip.include? " "
        @@results = self.search_keyword(search, admin)
      else
        @@results = self.search_phrase(search, admin)
      end

    else
      all.order(:first)
    end
  end

  # Search keyword within respective member or admin fields
  def self.search_keyword(search, admin)
    permissions = admin ? @@member.concat(@@admin_only) : @@member
    @@results = []

    for col in permissions
      self.update_results(col, search)
    end
    @@results
  end

  # Search for a phrase within respective member or admin fields
  def self.search_phrase(search, admin)
    search = search.split(" ")
    permissions = admin ? @@member.concat(@@admin_only) : @@member
    @@results = []

    for col in permissions
      for word in search
        self.update_results(col, word)
      end
    end
    @@results
  end

  #generalize updating @results for search
  def self.update_results(column, search)
    if column == "team"
      find = User.search_team_name(search)
    else
      find = User.where("lower(#{column}) LIKE lower(?)", "%#{search}%").order(:first)
    end

    @@results = @@results | find
  end

  ##Methods dealing with download-roster
  @@xml_columns = ["first", "last", "team", "major", "skillset", "sid", "linkedinLstring", "facebook", "code", "email", "year"]

  def to_XML
    xml_string = ""

    @@xml_columns.each do |column|
      xml_string += self.column_to_XML(column) + " "
    end

    return xml_string
  end

  def column_to_XML(column)
    if column == "code"
      return Gyoku.xml(:access => "access: #{self.access};")
    else
      column_sym = column.to_sym
      return Gyoku.xml(column_sym => "#{column}: #{self.send(column_sym)};")
    end
  end

  def access
    self.admin? ? "admin" : "regular"
  end

  def self.make_XML_file
    content = ""
    if User.all != nil
      User.all.each do |user|
        content += user.to_XML + "<br />\n"
      end
    end

    File.open(@@full_file_path, 'w') do |f|
      f.puts content
    end
  end

  def self.full_file_path
    @@full_file_path
  end

  def self.roster_file_name
    @@roster_file_name
  end

  ##methods dealing with teams

  #for calling in index.html
  def team_name
    self.team == nil ? "" : self.team.name
  end
end
