# frozen_string_literal: true

file_create 'Rakefile' do |f|
  require_relative 'prj'

  content = <<~CONTENT
    # frozen_string_literal: true

    $stdout.sync = $stderr.sync = true
  CONTENT

  content += <<~CONTENT if File.file?("#{Prj.name}.gemspec")

    require 'bundler/gem_tasks'

    require 'rspec/core/rake_task'
    RSpec::Core::RakeTask.new(:test) { |t| t.ruby_opts = %w[-w] }

    require 'yard'

    CLEAN << '.yardoc'
    CLOBBER << 'doc'

    YARD::Rake::YardocTask.new(:doc) { |t| t.stats_options = %w[--list-undoc] }

    desc 'Run YARD development server'
    task('doc:dev' => :clobber) { exec('yard server --reload') }
  CONTENT

  content += <<~CONTENT

    task(:default) { exec('rake --tasks') }
  CONTENT

  write f.name, content
end
