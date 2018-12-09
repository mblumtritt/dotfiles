# frozen_string_literal: true

desc 'create default Gemfile'
task gemfile: './gems.rb'

rule %r(gems.rb$) do |r|
  content = if Dir['*.gemspec'].empty?
    <<~GEMS_RB
      # frozen_string_literal: true

      source 'https://rubygems.org' do
        gem 'bundler'
        gem 'rake'
      end
    GEMS_RB
  else
    <<~GEMS_RB
      # frozen_string_literal: true

      source 'https://rubygems.org' do
        gemspec
      end
    GEMS_RB
  end
  write r.name, content
end
