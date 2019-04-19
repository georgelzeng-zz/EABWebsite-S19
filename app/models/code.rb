class Code < ActiveRecord::Base
  validates :code_type, uniqueness: true
  validates :code, uniqueness: true
  validate :correct_type

  ##Custom validation methods
  def correct_type
    if self.code_type != "regular" && self.code_type != "admin"
      errors.add(:code_type, "-- Not valid access code type")
    end
  end

  ##Strings for flash messages
  def self.code_uniqueness_message
    "Code-change failed: Access codes must be different from each other."
  end

  def self.changing_to_same_value(type, code)
    "#{type.capitalize} Code is already \"#{code}\""
  end

  def self.changed_successful_message(type, old_code, new_code)
    "#{type.capitalize} Code successfully changed from \"#{old_code}\" to \"#{new_code}\""
  end

  ##Getter method -- only valid types are "regular" and "admin" -- for generalizability
  def self.get_code(type)
    if Code.where(code_type: type)[0] == nil
      Code.create!(code_type: type, code: ENV["#{type.upcase}_CODE"])
    end

    return Code.where(code_type: type)[0].code
  end

  ##Getter methods for ease of typing
  def self.regular_code
    Code.get_code("regular")
  end

  def self.admin_code
    Code.get_code("admin")
  end

  ##Setter_method
  def self.set_code(type, newCode)
    Code.where(code_type: type).update_all(code: newCode)
  end
end
