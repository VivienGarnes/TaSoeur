class ImageCreator
	def self.create(pin)
	  Rails.logger.warn render('pins/tasoeur_vgt', pin)
	  kit = IMGKit.new(render('pins/tasoeur_vgt', pin), :quality => 50)
	  file = kit.to_file(Rails.root.to_s+'/public/tasoeur.png')
	  pin.quote = File.open(Rails.root.to_s+'/public/tasoeur.png')
	  pin.save
	end
	def self.render(partial, pin, assigns = {})
    view = ActionView::Base.new(ActionController::Base.view_paths, assigns)
    view.extend ApplicationHelper
    view.render(partial: partial, locals: { pin: pin })
  end
end