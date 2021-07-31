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

      $stdout.sync = $stderr.sync = true

      require 'rake/clean'
      require 'bundler/gem_tasks'
      require 'rake/testtask'

      CLOBBER << 'pkg'

      task(:default) { exec('rake --tasks') }

      Rake::TestTask.new(:test) do |task|
        task.pattern = 'test/**/*_test.rb'
        task.warning = task.verbose = true
      end
    CONTENT
  end
end
