require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  #tests for change-access-code feature
  it "calls the model method that changes the registration code" do
    newCode = "blah"
    expect(User).to receive(:change_registration_code).with(newCode)
    patch :registration_code, Regular_Access_Code: newCode
  end

  it "calls the model method that changes the admin code" do
    newCode = "blah"
    expect(User).to receive(:change_admin_code).with(newCode)
    patch :admin_code, Admin_Access_Code: newCode
  end
end
