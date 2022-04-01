class Imagem < ActiveRecord::Base
	belongs_to :participante

	has_attached_file :images,
			:validate_media_type => false,
          	:path => ':rails_root/public/images/participantes/:basename-:id.:extension',
			# :url => '/images/participantes/:basename-:id.:extension' funciona no localhost
			:url => '/iwind/images/participantes/:basename-:id.:extension' # para o servidor devido ao /cliente

	validates_attachment :images, 
			content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/bmp", "application/pdf"],
			message: 'Arquivos válidos jpg/jpeg/png/bmp/pdf com até 10Mb.' },
			:size => { :in => 0..10.megabytes }

	Paperclip.interpolates :id do |attachment, style|
	  "#{attachment.instance.participante.matricula}-#{attachment.instance.id}"
	end
end