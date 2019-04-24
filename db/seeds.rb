# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(first: 'Michael', last: 'Wu', email: 'michaelwu@berkeley.edu', team: 'exec', skillset: 'Paper, Sales', sid: '42042069', password: '123456', password_confirmation: '123456', code: User.registration_code)
User.create!(first: 'George', last: 'Zeng', email: 'glz@berkeley.edu', team: 'kiwi', skillset: 'Paper, Sales', sid: '1234578', password: '123456', password_confirmation: '123456', code: User.registration_code)
User.create!(first: 'Nick', last: 'cai', email: 'ncai@yahoo.com', team: 'cs169', skillset: 'Paper, Sales', sid: '12342342', password: '123456', password_confirmation: '123456', code: User.registration_code)
User.create!(first: 'Mihir', last: 'Chitalia', email: 'mhc@berkeley.edu', team: 'kiwi', skillset: 'Accounting, Numbers', sid: '12345679', password: '123456', password_confirmation: '123456', code: User.registration_code)
User.create!(first: 'Jason', last: 'Bi', email: 'jbi@berkeley.edu', team: 'cs169', skillset: 'Accounting, Numbers', sid: '13371384', password: '123456', password_confirmation: '123456', code: User.registration_code)
User.create!(first: 'Chau', last: 'Van', email: 'cv@berkeley.edu', team: 'kiwi', skillset: 'Accounting, Numbers', sid: '69420420', password: '123456', password_confirmation: '123456', code: User.registration_code)
User.create!(first: 'Kyle', last: 'Ngo', email: 'kylengo357@berkeley.edu', team: 'kiwi', skillset: 'Food, Drink, Eating', sid: '87654321', password: 'pancakes', password_confirmation: 'pancakes', code: User.admin_code)
User.create!(first: 'George', last: 'Zeng', email: 'georgelzeng@berkeley.edu', team: 'kiwi', skillset: 'Food, Drink, Eating', sid: '88654321', password: 'pancakes', password_confirmation: 'pancakes', code: User.admin_code)
User.create!(first: 'Mihir', last: 'Chitalia', email: 'mihirchitalia@berkeley.edu', team: 'kiwi', skillset: 'Food, Drink, Eating', sid: '87634321', password: 'pancakes', password_confirmation: 'pancakes', code: User.admin_code)
User.create!(first: 'Jason', last: 'Bi', email: 'bi.jason13@berkeley.edu', team: 'kiwi', skillset: 'Nothing', sid: '87654721', password: 'pancakes', password_confirmation: 'pancakes', code: User.admin_code)
User.create!(first: 'Chau', last: 'Van', email: 'c.van@berkeley.edu', team: 'kiwi', skillset: 'Nothing', sid: '87654921', password: 'pancakes', password_confirmation: 'pancakes', code: User.admin_code)
User.create!(first: 'Michael', last: 'Wu', email: 'wuxiaohua1011@berkeley.edu', team: 'kiwi', skillset: 'Nothing', sid: '47654321', password: 'pancakes', password_confirmation: 'pancakes', code: User.admin_code)
User.create!(first: 'Nick', last: 'Cai', email: 'ncaia@berkeley.edu', team: 'kiwi', skillset: 'Nothing', sid: '87654301', password: 'pancakes', password_confirmation: 'pancakes', code: User.admin_code)
