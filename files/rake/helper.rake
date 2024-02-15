# frozen_string_literal: true

def dir_for(file_name)
  dirname = File.dirname(file_name)
  mkdir_p dirname unless File.directory?(dirname)
end

def write(file_name, content = nil)
  puts "• write #{file_name}"
  dir_for file_name
  File.write file_name, content || yield
end
