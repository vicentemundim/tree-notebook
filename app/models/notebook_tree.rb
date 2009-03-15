class NotebookTree < RuGUI::BaseModel
  observable_property :name
  observable_property :current_displayed_node_iter

  attr_accessor :tree_model

  def from_hash(hash)
    self.tree_model = Gtk::TreeStore.new(String, String) # (node_name, node_contents)
    root_iter = self.tree_model.append(nil)
    set_node_values(root_iter, self.name, hash[:contents])

    parse_children(hash[:children], root_iter)
  end

  # TODO: used only for testing, remove it once loading from file is implemented.
  def self.sample_notebook_tree
    return {
      :contents => 'Root level note contents',
      :children => {
        :first_level_note => {
          :contents => 'First level note contents',
          :children => {
            :some_second_level_note => {
              :contents => 'Some second level note contents',
              :children => {}
            },
            :another_second_level_note => {
              :contents => 'another second level note contents',
              :children => {}
            }
          }
        },
        :another_first_level_note => {
          :contents => 'another first level note contents',
          :children => {
            :a_second_level_note => {
              :contents => 'a second level note contents',
              :children => {
                :even_a_third_level_note => {
                  :contents => 'some content',
                  :children => {}
                }
              }
            }
          }
        }
      }
    }
  end

  private
    def set_node_values(node_iter, name, contents)
      node_iter.set_value 0, name.to_s
      node_iter.set_value 1, contents.to_s
    end

    def parse_children(children, parent_iter)
      children.each do |node_name, node_data|
        child_iter = self.tree_model.append(parent_iter)
        set_node_values(child_iter, node_name, node_data[:contents])
        parse_children(node_data[:children], child_iter)
      end
    end
end
