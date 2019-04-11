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

  def self.search(search, admin)
    if !search.blank?
      if !search.strip.include? " "
        # if member -- currently the only option
        @access = []
        if admin
          @access =
            User.where("email = lower(?)", "#{search}").order(:first) |
            User.where("sid = ?", "#{search}").order(:first)
        end

        @results =
          User.where("lower(first) = lower(?)", "#{search}").order(:first) |
          User.where("lower(last) = lower(?)", "#{search}").order(:first) |
          User.where("lower(team) = lower(?)", "#{search}").order(:first)

        @results = @results | @access

      else
        # split search string for full name search exact match or backwards
        # phrase search for ease of member usage only
        search = search.split(" ")
#zeng george kiwi
        @results =
          (User.where("lower(first) = lower(?)", "#{search[0]}") &
          User.where("lower(last) = lower(?)", "#{search[1]}") &
          User.where("lower(team) = lower(?)", "#{search[2]}")) |

          (User.where("lower(first) = lower(?)", "#{search[0]}") &
          User.where("lower(last) = lower(?)", "#{search[1]}")) |

          (User.where("lower(first) = lower(?)", "#{search[1]}") &
          User.where("lower(last) = lower(?)", "#{search[0]}") |
          User.where("lower(team) = lower(?)", "#{search[2]}")) |

          (User.where("lower(first) = lower(?)", "#{search[1]}") &
          User.where("lower(last) = lower(?)", "#{search[0]}") &
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
