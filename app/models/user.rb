class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	validates :sid, uniqueness: true
	validates :first, :last, :email, :sid, presence: true
  validate :correct_access_code
  @@registration_code = "Michael"
  @@admin_code = "Michael Wu"

  def correct_access_code
    if self.code != @@registration_code && self.code != @@admin_code
      errors.add(:code, "-- Wrong access code")
    end
  end

  def admin?
    self.code == @@admin_code
  end
end
