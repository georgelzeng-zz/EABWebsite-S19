class Code < ActiveRecord::Base
  validates :code_type, uniqueness: true
  validates :code, uniqueness: true
  validate :correct_type


  #Custom validation methods
  def correct_type
    if self.code_type != "regular" && self.code_type != "admin"
      errors.add(:code_type, "-- Not valid access code type")
    end
  end


  #Strings for flash messages
  def self.code_uniqueness_message
    "Code-change failed: Access codes must be different from each other."
  end

  def self.changing_to_same_value(type, code)
    "#{type} Code is already \"#{code}\""
  end

  def self.changed_successful_message(type, old_code, new_code)
    "#{type} Code successfully changed from \"#{old_code}\" to \"#{new_code}\""
  end


  #Getter methods
  def self.regular_code
    if Code.where(code_type: "regular")[0] == nil
      Code.create!(code_type: "regular", code: ENV["ACCESS_CODE"])
    end

    return Code.where(code_type: "regular")[0].code
  end

  def self.admin_code
    if Code.where(code_type: "admin")[0] == nil
      Code.create!(code_type: "admin", code: ENV["ADMIN_CODE"])
    end

    return Code.where(code_type: "admin")[0].code
  end


  #Setter_methods
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
