# frozen_string_literal: true

desc 'create default Gemfile'
task gemfile: './gems.rb'

rule /gems.rb$/ do |r|
  write r.name do
    if Gemspec.present?(File.dirname(r.name))
      GemFile.using_gemspec
    else
      GemFile.default
    end
  end
end

module GemFile
  def self.default
    <<~CONTENT
      # frozen_string_literal: true

      source 'https://rubygems.org'
      gem 'bundler'
      gem 'rake', group: %i[development test]
    CONTENT
  end

  def self.using_gemspec
    <<~CONTENT
      # frozen_string_literal: true

      source 'https://rubygems.org'
      gemspec
    CONTENT
  end
end
