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
