class Code < ActiveRecord::Base
  validates :code_type, uniqueness: true
  validates :code, uniqueness: true
  validate :correct_type

  def correct_type
    if self.code_type != "regular" && self.code_type != "admin"
      errors.add(:code_type, "-- Not valid access code type")
    end
  end

  def self.regular_code
    if Code.where(code_type: "regular")[0] == nil
      Code.create!(code_type: "regular", code: ENV["ACCESS_CODE"])
    end

    Code.where(code_type: "regular")[0].code
  end

  def self.admin_code
    if Code.where(code_type: "admin")[0] == nil
      Code.create!(code_type: "admin", code: ENV["ADMIN_CODE"])
    end

    Code.where(code_type: "admin")[0].code
  end

  def self.set_regular_code(newCode)
    code = Code.where(code_type: "regular")[0]
    code.code = newCode
    code.save!
  end

  def self.set_admin_code(newCode)
    code = Code.where(code_type: "admin")[0]
    code.code = newCode
    code.save!
  end
end
