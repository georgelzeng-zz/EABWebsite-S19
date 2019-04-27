class AddAttachmentAttachmentToTeams < ActiveRecord::Migration
  def self.up
    change_table :teams do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :teams, :attachment
  end
end
