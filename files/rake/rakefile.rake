# frozen_string_literal: true

desc 'create default Rakefile'
task rakefile: './rakefile.rb'

rule /rakefile.rb$/ do |r|
  write r.name do
    if Gemspec.present?(File.dirname(r.name))
      Rakefile.using_gem
    else
      Rakefile.default
    end
  end
end

module Rakefile
  def self.default
    <<~CONTENT
      # frozen_string_literal: true

      $stdout.sync = $stderr.sync = true
      task(:default) { exec('rake --tasks') }
    CONTENT
  end

  def self.using_gem
    <<~CONTENT
      # frozen_string_literal: true

      require 'rake/clean'
      require 'bundler/gem_tasks'
      require 'rspec/core/rake_task'

      $stdout.sync = $stderr.sync = true
      CLOBBER << 'prj'
      task(:default) { exec('rake --tasks') }
      task(test: :spec)
      RSpec::Core::RakeTask.new { |task| task.ruby_opts = %w[-w] }
    CONTENT
  end
end

task :mike, %i[a b] do |_task, args|
  pp args.to_h
end
