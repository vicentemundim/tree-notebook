class NotebookTreeView < ApplicationView
  root :notebook_tree
  use_glade

  def prepare_notebook_tree(model)
    renderer = Gtk::CellRendererText.new
    col = Gtk::TreeViewColumn.new("Notes", renderer, :text => 0)
    self.notebook_tree.append_column(col)
    self.notebook_tree.model = model
  end
end
