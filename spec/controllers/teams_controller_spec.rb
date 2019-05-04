require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user, {email: "user@gmail.com", sid: "0", code: Code.regular_code})
    @user_with_team = FactoryBot.create(:user, {email: "user_with_team@gmail.com", sid: "1", code: Code.regular_code})
    @team = Team.seed_team("user_with_team@gmail.com", "test_name", "password")
    sign_in(@user)
  end

  it "makes sure only team leader can use the PATCH promote_to_leader action" do
    patch "promote_to_leader", {id: @team.id, user_id: @user.id}
    expect(@team.leader).not_to eq(@user)
    expect(@team.leader).to eq(@user_with_team)
  end

  it "makes sure only team leader can use the delete action" do
    #need to reassign @user_with_team variable because record got updated
    @user_with_team = User.find_by email: "user_with_team@gmail.com"
    delete "delete", {id: @team.id}
    expect(@user_with_team.team).not_to eq(nil)
  end
end
