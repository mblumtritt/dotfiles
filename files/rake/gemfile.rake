# frozen_string_literal: true

desc 'create default Gemfile'
task gemfile: './Gemfile'

rule /Gemfile$/ do |r|
  write r.name, GemFile.content
end

module GemFile
  def self.content
    <<~CONTENT
      # frozen_string_literal: true

      source 'https://rubygems.org'

      group :development, :test do
        gem 'bundler'
        gem 'prettier'
        gem 'rake'
      end

      # group :development do
      #   gem 'yard'
      # end

      group :test do
        gem 'rspec'
      end

      gemspec
    CONTENT
  end
end
