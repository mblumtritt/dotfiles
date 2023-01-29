# frozen_string_literal: true

file_create 'Gemfile' do |f|
  require_relative 'prj'

  content = <<~CONTENT
    # frozen_string_literal: true

    source 'https://rubygems.org'

    group :development, :test do
      gem 'bundler', require: false
      gem 'rake', require: false
    end
  CONTENT

  content += <<~CONTENT if File.file?('.yardopts')

    group :development do
      gem 'prettier', require: false
      gem 'yard', require: false
    end
  CONTENT

  content += <<~CONTENT if File.directory?('spec')

    group :test do
      gem 'rspec', require: false
    end
  CONTENT

  content += <<~CONTENT if File.file?("#{Prj.name}.gemspec")

    gemspec
  CONTENT

  write f.name, content
end

file_create 'Gemfile.lock' do
  sh 'bundle update'
end
