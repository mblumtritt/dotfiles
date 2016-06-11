def want(what, *args)
  Rake::Task[what].invoke(*args)
end

def reformat(content)
  content = content.lines
  first_line = content[0]
  lws = first_line.size - first_line.lstrip.size
  content.map!{ |line| (line[lws..-1] || line).rstrip }.push(nil).join($/)
end

def mkdir_for(file_name)
  dirname = File.dirname(file_name)
  mkdir_p dirname unless File.exist?(dirname)
end

def write(file_name, content)
  mkdir_for(file_name)
  puts "write #{file_name}"
  IO.write(file_name, reformat(content))
end
