class AddAttachmentImagesToImagens < ActiveRecord::Migration
  def self.up
    change_table :imagens do |t|
      t.attachment :images
    end
  end

  def self.down
    remove_attachment :imagens, :images
  end
end
