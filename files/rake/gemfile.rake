# frozen_string_literal: true

desc 'create default Gemfile'
task gemfile: './gems.rb'

rule %r{gems.rb$} do |r|
  if Gemspec.present?(File.dirname(r.name))
    write r.name, GemFile.using_gemspec
  else
    write r.name, GemFile.default
  end
end

module GemFile
  def self.default
    <<~CONTENT
      # frozen_string_literal: true

      source 'https://rubygems.org' do
        gem 'bundler'
        gem 'rake'
      end
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
