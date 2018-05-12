desc 'create default Gemfile'
task gemfile: './gems.rb'

rule %r(gems.rb$) do |r|
  content = if Dir['*.gemspec'].empty?
    <<~EOF
      # frozen_string_literal: true

      source 'https://rubygems.org' do
        gem 'bundler'
        gem 'rake'
      end
    EOF
  else
    <<~EOF
      # frozen_string_literal: true

      source 'https://rubygems.org' do
        gemspec
      end
    EOF
  end
  write r.name, content
end
