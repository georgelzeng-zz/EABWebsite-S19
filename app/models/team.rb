class Team < ActiveRecord::Base
  validates :name, uniqueness: true
	validates :name, :password, presence: true

  belongs_to :leader, :class_name => "User", :foreign_key => "user_id"
  has_many :members, :class_name => "User"

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_attachment_size :image, :less_than => 5.megabytes

  #helper create_team method for testing and seeding
  def self.seed_team(leaders_email, team_name, team_password)
    team_leader = User.find_by email: leaders_email
    new_team = Team.create!(name: team_name, user_id: team_leader.id, password: team_password)
    team_leader.update!(team_id: new_team.id)
    return new_team
  end
end
