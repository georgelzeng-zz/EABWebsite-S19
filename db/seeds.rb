# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Code.create!(code_type: "regular", code: ENV["REGULAR_CODE"])
Code.create!(code_type: "admin", code: ENV["ADMIN_CODE"])

User.create!(first: 'Kyle', last: 'Ngo', email: 'kylengo357@berkeley.edu', year: 'Senior', major: 'Basket Weaving', skillset: 'None', facebook: 'facebook.com/kylengo357', linkedinLstring: 'linkedin.com/in/kyle-ngo-a78815155/', sid: '87654321', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)

User.create!(first: 'Bobby', last: 'James', email: 'kylengo357@gmail.com', year: 'Freshman', major: 'Political Science', skillset: 'None', sid: '47054391', password: 'pancakes', password_confirmation: 'pancakes', code: Code.regular_code)
User.create!(first: 'Jonathan', last: 'Hill', email: 'jonhill@gmail.com', year: 'Junior', major: 'Business', skillset: 'None', sid: '4629957097', password: 'pancakes', password_confirmation: 'pancakes', code: Code.regular_code)
User.create!(first: 'Jennifer', last: 'White', email: 'jennifer123@gmail.com', year: 'Junior', major: 'Business', skillset: 'None', sid: '2174600215', password: 'pancakes', password_confirmation: 'pancakes', code: Code.regular_code)

User.create!(first: 'Anna', last: 'Smith', email: 'blankityblankbizmark@gmail.com', year: '2022', major: 'EECS', skillset: 'None', sid: '38654797', password: 'pancakes', password_confirmation: 'pancakes', code: Code.regular_code)

def seed_team_pancakes(leaders_email, team_name)
  return Team.seed_team(leaders_email, team_name, "pancakes")
end

team_kiwi = seed_team_pancakes("kylengo357@berkeley.edu", "kiwi")
team_dog = seed_team_pancakes("kylengo357@gmail.com", "dog")
team_red = seed_team_pancakes("jonhill@gmail.com", "red team")
team_blue = seed_team_pancakes("jennifer123@gmail.com", "blue team")
team_chair = seed_team_pancakes("blankityblankbizmark@gmail.com", "chair")

User.create!(first: 'George', last: 'Zeng', email: 'georgelzeng@berkeley.edu', team_id: team_kiwi.id, year: '2019', major: 'Computer Science', skillset: 'None', sid: '88654321', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'Mihir', last: 'Chitalia', email: 'mihirchitalia@berkeley.edu', team_id: team_kiwi.id, year: '2019', major: 'Media Studies', skillset: 'None', sid: '87634321', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'Jason', last: 'Bi', email: 'bi.jason13@berkeley.edu', team_id: team_kiwi.id, year: 'Sophomore', major: 'Art History', skillset: 'None', sid: '87654721', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'Chau', last: 'Van', email: 'c.van@berkeley.edu', team_id: team_kiwi.id, year: 'Sophomore', major: 'EECS', skillset: 'None', sid: '87654921', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'Michael', last: 'Wu', email: 'wuxiaohua1011@berkeley.edu', team_id: team_kiwi.id, year: 'Senior', major: 'Business', skillset: 'None', sid: '47654321', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'Nick', last: 'Cai', email: 'ncaia@berkeley.edu', team_id: team_kiwi.id, year: 'Freshman', major: 'Computer Science', skillset: 'None', sid: '87654301', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)

User.create!(first: 'Eric', last: 'Brown', email: 'ebrown@gmail.com', team_id: team_chair.id, year: '2020', major: 'Computer Science', skillset: 'None', sid: '8241025001', password: 'pancakes', password_confirmation: 'pancakes', code: Code.regular_code)
