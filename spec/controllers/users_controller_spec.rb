require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

RSpec.describe UsersController, type: :controller do
  #tests for change-access-code feature
  before(:each) do
    @admin_user = FactoryGirl.create(:admin, {email: "admin@gmail.com", sid: "0", code: Code.admin_code})
    sign_in(@admin_user)
  end

  it "calls the model method that changes the registration code" do
    newCode = "blah"
    expect(User).to receive(:change_registration_code).with(newCode)
    patch "registration_code", registration_code: newCode
  end

  it "changes the registration code" do
    newCode = "blah"
    patch "registration_code", registration_code: newCode
    expect(Code.regular_code).to eq(newCode)
  end

  it "calls the model method that changes the admin code" do
    newCode = "blah"
    expect(User).to receive(:change_admin_code).with(newCode)
    patch "admin_code", admin_code: newCode
  end

  it "changes the admin code" do
    newCode = "blah"
    patch "admin_code", admin_code: newCode
    expect(Code.admin_code).to eq(newCode)
  end
end
