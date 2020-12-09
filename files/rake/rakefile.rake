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

      STDOUT.sync = STDERR.sync = true

      task :default do
        exec 'rake --tasks'
      end
    CONTENT
  end

  def self.using_gem
    <<~CONTENT
      # frozen_string_literal: true

      STDOUT.sync = STDERR.sync = true

      require 'rake/clean'
      require 'bundler/gem_tasks'
      require 'rake/testtask'

      task :default do
        exec 'rake --tasks'
      end

      Rake::TestTask.new(:test) do |task|
        task.ruby_opts = %w[-w]
        task.verbose = true
        task.test_files = FileList['test/**/*_test.rb']
      end
    CONTENT
  end
end
