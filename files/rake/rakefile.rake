# frozen_string_literal: true

desc 'create default Rakefile'
task rakefile: './Rakefile'

rule /Rakefile$/ do |r|
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
      # require 'yard'

      $stdout.sync = $stderr.sync = true

      CLEAN << '.yardoc'
      CLOBBER << 'prj' << 'doc'

      task(:default) { exec('rake --tasks') }
      task(test: :spec)
      RSpec::Core::RakeTask.new { |task| task.ruby_opts = %w[-w] }

      # YARD::Rake::YardocTask.new { |task| task.stats_options = %w[--list-undoc] }
      # desc 'Run YARD development server'
      # task('yard:dev' => :clobber) { exec('yard server --reload') }
    CONTENT
  end
end
