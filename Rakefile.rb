require 'rake'
require 'fileutils'

task :remove_files do
  path = 'new_files'

  if Dir.exist?(path)
    FileUtils.rm_rf(path)
    puts "All new files removed."
  else
    puts "No new files."
  end
end
