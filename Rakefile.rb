require 'rake'
require 'fileutils'

task :remove_folder , [:folder] do |t, args|
  args.with_defaults(folder: 'new_files')
  path = args[:folder]

  if Dir.exist?(path)
    FileUtils.rm_rf(path)
    puts "Folder and files within removed."
  else
    puts "No new files."
  end
end
