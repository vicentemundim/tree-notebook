class MainController < RuGUI::BaseMainController
  def setup_views
    register_view :main_view
    register_view :about_view
  end

  def open_about_dialog(widget)
    self.about_view.about_dialog.show
  end

  def quit_application(widget = nil, event = nil)
    # TODO: add hooks here, to prevent quitting the application without saving working data.
    quit
  end
end
