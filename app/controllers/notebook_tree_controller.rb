class NotebookTreeController < ApplicationController
  def setup_models
    register_model main_controller.notebook_tree
  end

  def setup_views
    register_view :notebook_tree_view
  end

  def post_registration
    self.notebook_tree.name = "My Notebook"
    self.notebook_tree.from_hash(NotebookTree.sample_notebook_tree)

    main_controller.main_view.include_view(:notebook_tree_container, self.notebook_tree_view)
    self.notebook_tree_view.prepare_notebook_tree(self.notebook_tree.tree_model)

    main_controller.main_view.notebook_textview.buffer.signal_connect('insert-text') do |textbuffer, iter, text, length|
      save_contents_on_current_display_node(textbuffer.text) unless textbuffer.text.blank?
    end
  end

  def on_notebook_tree_row_activated(widget, path, column)
    self.notebook_tree.current_displayed_node_iter = self.notebook_tree.tree_model.get_iter(path)
  end

  def property_current_displayed_node_iter_changed(model, new_value, old_value)
    main_controller.main_view.notebook_textview.buffer.text = new_value.get_value(1)
  end

  def save_contents_on_current_display_node(contents)
    self.notebook_tree.current_displayed_node_iter.set_value(1, contents)
  end
end
