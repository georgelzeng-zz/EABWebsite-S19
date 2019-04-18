# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Code.create!(code_type: "regular", code: ENV["ACCESS_CODE"])
Code.create!(code_type: "admin", code: ENV["ADMIN_CODE"])

User.create!(first: 'Kyle', last: 'Ngo', email: 'kylengo357@berkeley.edu', team: 'kiwi', skillset: 'None', sid: '87654321', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'George', last: 'Zeng', email: 'georgelzeng@berkeley.edu', team: 'kiwi', skillset: 'None', sid: '88654321', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'Mihir', last: 'Chitalia', email: 'mihirchitalia@berkeley.edu', team: 'kiwi', skillset: 'None', sid: '87634321', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'Jason', last: 'Bi', email: 'bi.jason13@berkeley.edu', team: 'kiwi', skillset: 'None', sid: '87654721', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'Chau', last: 'Van', email: 'c.van@berkeley.edu', team: 'kiwi', skillset: 'None', sid: '87654921', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'Michael', last: 'Wu', email: 'wuxiaohua1011@berkeley.edu', team: 'kiwi', skillset: 'None', sid: '47654321', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
User.create!(first: 'Nick', last: 'Cai', email: 'ncaia@berkeley.edu', team: 'kiwi', skillset: 'None', sid: '87654301', password: 'pancakes', password_confirmation: 'pancakes', code: Code.admin_code)
