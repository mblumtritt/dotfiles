# frozen_string_literal: true

require_relative 'prj'

def write(file_name, content = nil)
  puts "write #{file_name}"
  File.write(file_name, content || yield)
end

desc 'Add all parts required for a Ruby gem'
task(
  'prep:gem' => %W[
    .gitignore
    #{"lib/#{Prj.name}.rb"}
    #{"#{Prj.name}.gemspec"}
    README.md
    stats.md
    .yardopts
    spec/#{Prj.name}/version_spec.rb
    spec/#{Prj.name}/#{Prj.name}_spec.rb
    Rakefile
    Gemfile
    Gemfile.lock
  ]
)
