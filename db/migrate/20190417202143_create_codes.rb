class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :code_type
      t.string :code
      t.timestamps null: false
    end
  end
end
