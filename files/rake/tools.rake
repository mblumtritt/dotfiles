def want(what, *args)
  Rake::Task[what].invoke(*args)
end

def mkdir_for(file_name)
  dirname = File.dirname(file_name)
  mkdir_p dirname unless File.exist?(dirname)
end

def write(file_name, content)
  puts "write #{file_name}"
  mkdir_for(file_name)
  IO.write(file_name, content)
end
