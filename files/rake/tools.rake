# frozen_string_literal: true

def want(task, *args)
  Rake::Task[task].invoke(*args)
end

def ordered(*tasks)
  tasks.flatten.each{ |task| want(task) }
end

def mkdir_for(file_name)
  dirname = File.dirname(file_name)
  mkdir_p(dirname) unless File.exist?(dirname)
end

def write(file_name, content)
  mkdir_for(file_name)
  puts "write #{file_name}"
  IO.write(file_name, content)
end
