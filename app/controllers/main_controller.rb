class MainController < RuGUI::BaseMainController
  def setup_models
    register_model :notebook_tree
  end

  def setup_controllers
    register_controller :notebook_tree_controller
  end

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
