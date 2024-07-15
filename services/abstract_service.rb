require_relative '../translation'

class AbstractService
  include ::Translation

  def call
    raise NotImplemented, "Please define #call method"
  end

  private

  def check_file_presence(file_path)
    unless File.exist?(file_path)
      translate(:file_not_found)
      return
    end
    return file_path
  end
end
