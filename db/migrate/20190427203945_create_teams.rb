class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      #description is the same as Team Bio (used in views)
      t.string :description
      t.string :password

      t.timestamps null: false
    end
  end
end
