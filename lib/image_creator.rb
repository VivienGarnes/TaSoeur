class ImageCreator
  def self.create(pin)
    file = Tempfile.new(["template_#{pin.id.to_s}", '.png'], 'tmp', encoding: 'ascii-8bit')
    file.write(IMGKit.new(render('pins/tasoeur_vgt', pin), quality: 100, width: 500, height: 500).to_png)
    file.flush
    pin.quote = file
    pin.save
    file.unlink
  end
  def self.render(partial, pin, assigns = {})
    view = ActionView::Base.new(ActionController::Base.view_paths, assigns)
    view.extend ApplicationHelper
    view.render(partial: partial, locals: { pin: pin })
  end
end
