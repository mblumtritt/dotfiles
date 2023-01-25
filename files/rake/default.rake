# frozen_string_literal: true

require_relative 'prj'

directory Prj.dir
directory 'spec'

def write(file_name, content = nil)
  puts "✏️  #{file_name}"
  File.write(file_name, content || yield)
end

desc 'Add all parts required for a Ruby gem'
task 'prep:gem' => [
       '.gitignore',
       Prj.file,
       Prj.gemspec,
       'README.md',
       'stats.md',
       '.yardopts',
       'spec/version_spec.rb',
       'Rakefile',
       'Gemfile',
       'Gemfile.lock'
     ]
