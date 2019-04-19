require "factory_girl_rails"
#
def create_visitor
  @visitor ||= { :first => "Testy", :last => 'McUserton', :email => "example@example.com",
    :password => "changeme", :password_confirmation => "changeme", :sid => "9999999999", :code => Code.regular_code }
end

def create_admin_visitor
  @visitor = { :first => "Admin", :last => 'Adminton', :email => "admin@admin.com",
  :password => "changeme", :password_confirmation => "changeme", :sid => "11111111", :code =>  Code.admin_code }
end

def find_user
  @user = User.where(:email => @visitor[:email]).first
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

def create_admin
  create_admin_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

def delete_user
  @user = User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_first", :with => @visitor[:first]
  fill_in "user_last", :with => @visitor[:last]
  fill_in "user_sid", :with => @visitor[:sid]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  fill_in "user_code", :with => @visitor[:code]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/users/sign_in'
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Log in"
end

### GIVEN ###
Given /^I am not logged in$/ do
  visit '/'
  step %{follow "Logout"}
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

Given /^I am logged in as "(.*)"$/ do |userType|
  step %{I am not logged in}
  case userType
  when "a regular user"
    @code = Code.regular_code
  when "an admin"
    @code = Code.admin_code
  end

  create_visitor
  @visitor[:code] = @code
  sign_up
end

Given /^I exist as a user$/ do
  create_user

end

Given /^the following users exist$/ do |users_table|
  users_table.map_column!('code') do |code|
    case code
    when 'registration_code'
      code = Code.regular_code
    when 'admin_code'
      code = Code.admin_code
    end
    code
  end

  users_table.hashes.each do |user|
    User.create!(user)
  end
end

Given /^I exist as an admin$/ do
  create_admin
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

Given /^I start signing up with valid user data$/ do
  create_visitor
end

Given /^the current "(.*)" is "(.*)"$/ do |code_type, code|
  case code_type
  when "regular access code"
    User.change_code("regular", code)
  when "admin access code"
    User.change_code("admin", code)
  else
    raise ArgumentError, 'Not a valid code type'
  end

  find_user
end

### WHEN ###
When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign in as an admin$/ do
  create_admin_visitor
  sign_in
end

When /^I sign out$/ do
  visit '/users/sign_out'
end

When /^I view users$/ do
  visit '/users/'
end

When /^I sign up$/ do
  sign_up
end

When /^I register my "(.*)" as "(.*)"$/ do |field, value|
  case value
  when "the admin code"
    value = Code.admin_code
  when "the access code"
    value = Code.regular_code
  when "not the admin code"
    value = Code.admin_code + Code.regular_code + 'nonsense'
  end

  @visitor = @visitor.merge(field.to_sym => value)
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I select a user$/ do

end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

When(/^I save the edit form$/) do
  click_button "Update"
end

When /^I edit my account name$/ do
  click_link "Edit account"
  fill_in "user_name", :with => "newname"
  fill_in "user_current_password", :with => @visitor[:password]
end

When /^I edit my email address$/ do
  click_link "Edit account"
  fill_in "user_email", :with => "newemail@example.com"
  fill_in "user_current_password", :with => @visitor[:password]
end

When(/^I don't enter my current password$/) do
  fill_in "user_current_password", :with => ""
end

When(/^I edit my email address with an invalid email$/) do
  click_link "Edit account"
  fill_in "user_email", :with => "notanemail"
  fill_in "user_current_password", :with => @visitor[:password]
end

When(/^I edit my password$/) do
  click_link "Edit account"
  fill_in "user_password", :with => "newpassword"
  fill_in "user_password_confirmation", :with => "newpassword"
  fill_in "user_current_password", :with => @visitor[:password]
end

When(/^I edit my password with missing confirmation$/) do
  click_link "Edit account"
  fill_in "user_password", :with => "newpassword"
  fill_in "user_current_password", :with => @visitor[:password]
end

When(/^I edit my password with missmatched confirmation$/) do
  click_link "Edit account"
  fill_in "user_password", :with => "newpassword"
  fill_in "user_password_confirmation", :with => "newpassword123"
  fill_in "user_current_password", :with => @visitor[:password]
end

When /^I look at the list of users$/ do
  visit '/'
end

When /^I change the "(.*)" to "(.*)"$/ do |code_type, code|
  step %{I am on the homepage}
  step %{I press "Search Users"}

  step %{I should be on the Database page}
  step %{I should be an admin}

  step %{I follow "Admin View"}

  case code_type
  when "Regular Access Code"
    textField = :registration_code
  when "Admin Access Code"
    textField = "admin_code"
  end

  step %{I should be on the Admin Database page}

  step %{I fill in "#{textField}" with "#{code}"}
  step %{I press "Change #{code_type}"}
end

### THEN ###
Then /^I should be an admin$/ do
  expect(@user.admin?).to be(true)
end

Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "Forgot your password?"
  page.should_not have_content "Logout"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I should see a notice to sign in or sign up$/ do
  page.should have_content "You need to sign in or sign up before continuing."
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^I should see I am not logged in$/ do
  page.should have_content "You aren't logged in!"
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password confirmation doesn't match"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password confirmation doesn't match"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid Email or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then(/^I should see a current password missing message$/) do
  page.should have_content "Current password can't be blank"
end

Then /^I should see my name$/ do
  create_user
  page.should have_content @user[:name]
end

Then /^I should see every users' email$/ do
  User.all.each do |user|
    page.should have_content user[:email]
  end
end

Then /(.*) seed users should exist/ do | n_seeds |
  User.count.should be n_seeds.to_i + 1
end

Then /I should see all the users/ do
  User.all.each do |user|
    step %{I should see "#{user.first}"}
  end
end

Then /I should see that "(.*)" is before "(.*)"/ do |e1, e2|
  expect(page.body.index(e1) < page.body.index(e2))
end

Then /^I click on my profile picture$/ do
  page.should have_link "Logout"
end
