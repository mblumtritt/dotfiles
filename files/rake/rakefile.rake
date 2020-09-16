# frozen_string_literal: true

desc 'create default Rakefile'
task rakefile: './rakefile.rb'

rule %r(rakefile.rb$) do |r|
  if Gemspec.present?(File.dirname(r.name))
    write r.name, Rakefile.using_gem
  else
    write r.name, Rakefile.default
  end
end

module Rakefile
  def self.default
    <<~CONTENT
      # frozen_string_literal: true

      STDOUT.sync = STDERR.sync = true

      task :default do
        exec "\#{$PROGRAM_NAME} --tasks"
      end
    CONTENT
  end

  def self.using_gem
    <<~CONTENT
      # frozen_string_literal: true

      require 'rake/clean'
      require 'bundler/gem_tasks'
      require 'rake/testtask'

      STDOUT.sync = STDERR.sync = true

      task :default do
        exec "\#{$PROGRAM_NAME} --tasks"
      end

      Rake::TestTask.new(:test) do |t|
        t.ruby_opts = %w[-w]
        t.verbose = true
        t.test_files = FileList['test/**/*_test.rb']
      end
    CONTENT
  end
end
