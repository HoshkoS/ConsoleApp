require_relative './services/create_file'
require_relative './services/read_file'
require_relative './services/update_file'
require_relative './services/filter_file'
require_relative './services/null_action'

class FileFactory
  ACTIONS = {
    :read => ReadFile,
    :create => CreateFile,
    :update => UpdateFile,
    :filter => FilterFile
  }

  def self.call(action_name)
    action = ACTIONS.fetch(action_name, NullAction)
    action.new.call
  end
end
