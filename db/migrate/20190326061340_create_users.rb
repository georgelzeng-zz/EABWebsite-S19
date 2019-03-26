class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first
      t.string :last
      t.string :email
      t.string :team
      t.string :major
      t.string :skillset
      t.string :sid
      t.string :linkedinLstring
      t.string :facebook
      t.string :privileges

      t.timestamps null: false
    end
  end
end
