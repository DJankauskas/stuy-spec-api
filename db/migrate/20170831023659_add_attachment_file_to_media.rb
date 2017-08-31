class AddAttachmentFileToMedia < ActiveRecord::Migration[5.1]
  def self.up
    change_table :media do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :media, :file
  end
end
