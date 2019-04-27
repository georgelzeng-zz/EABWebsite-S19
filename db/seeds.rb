# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Code.create!(code_type: "regular", code: ENV["REGULAR_CODE"])
Code.create!(code_type: "admin", code: ENV["ADMIN_CODE"])

User.create!(first: 'Kyle', last: 'Ngo', email: 'kylengo357@berkeley.edu', skillset: 'None', sid: '87654321', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)

User.create!(first: 'Bobby', last: 'James', email: 'kylengo357@gmail.com', skillset: 'None', sid: '47054391', password: 'pancakes', password_confirmation: 'pancakes', code: Code.regular_code)
User.create!(first: 'Jonathan', last: 'Hill', email: 'jonhill@gmail.com', skillset: 'None', sid: '4629957097', password: 'pancakes', password_confirmation: 'pancakes', code: Code.regular_code)
User.create!(first: 'Jennifer', last: 'White', email: 'jennifer123@gmail.com', skillset: 'None', sid: '2174600215', password: 'pancakes', password_confirmation: 'pancakes', code: Code.regular_code)

User.create!(first: 'Anna', last: 'Smith', email: 'blankityblankbizmark@gmail.com', skillset: 'None', sid: '38654797', password: 'pancakes', password_confirmation: 'pancakes', code: Code.regular_code)

def seed_team(leaders_email, team_name)
  team_leader = User.find_by email: leaders_email
  new_team = Team.create!(name: team_name, user_id: team_leader.id, password: "pancakes")
  team_leader.update!(team_id: new_team.id)
  return new_team
end

team_kiwi = seed_team("kylengo357@berkeley.edu", "kiwi")
team_dog = seed_team("kylengo357@gmail.com", "dog")
team_red = seed_team("jonhill@gmail.com", "red team")
team_blue = seed_team("jennifer123@gmail.com", "blue team")
team_chair = seed_team("blankityblankbizmark@gmail.com", "chair")

User.create!(first: 'George', last: 'Zeng', email: 'georgelzeng@berkeley.edu', team_id: team_kiwi.id, skillset: 'None', sid: '88654321', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'Mihir', last: 'Chitalia', email: 'mihirchitalia@berkeley.edu', team_id: team_kiwi.id, skillset: 'None', sid: '87634321', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'Jason', last: 'Bi', email: 'bi.jason13@berkeley.edu', team_id: team_kiwi.id, skillset: 'None', sid: '87654721', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'Chau', last: 'Van', email: 'c.van@berkeley.edu', team_id: team_kiwi.id, skillset: 'None', sid: '87654921', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'Michael', last: 'Wu', email: 'wuxiaohua1011@berkeley.edu', team_id: team_kiwi.id, skillset: 'None', sid: '47654321', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'Nick', last: 'Cai', email: 'ncaia@berkeley.edu', team_id: team_kiwi.id, skillset: 'None', sid: '87654301', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)

User.create!(first: 'Eric', last: 'Brown', email: 'ebrown@gmail.com', team_id: team_chair.id, skillset: 'None', sid: '8241025001', password: 'pancakes', password_confirmation: 'pancakes', code: Code.regular_code)
