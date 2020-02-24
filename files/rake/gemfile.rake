# frozen_string_literal: true

desc 'create default Gemfile'
task gemfile: './gems.rb'

rule %r(gems.rb$) do |r|
  if Dir[File.join(File.dirname(r.name, '*.gemspec'))].empty?
    write r.name, <<~GEMS_RB
      # frozen_string_literal: true

      source 'https://rubygems.org' do
        gem 'bundler'
        gem 'rake'
      end
    GEMS_RB
  else
    write r.name, <<~GEMS_RB
      gemspec
    GEMS_RB
  end
end
