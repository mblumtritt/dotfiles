# frozen_string_literal: true

module Gem
  class << self
    attr_reader :name, :module
  end

  @name = (ENV['NAME'] || File.basename(Dir.pwd)).freeze
  @module = @name.split(/[-_]/).map!(&:capitalize).join.freeze
end

desc "Create structure for gem '#{Gem.name}' in './'"
task gem: %W[
       #{Gem.name}.gemspec
       .yardopts
       Gemfile.lock
       Rakefile
       README.md
       stats.md
       .gitignore
     ] do
  exec('bundle exec rake test')
end

file_create 'README.md' do |f|
  write f.name, <<~README
    # #{Gem.module}
    <!-- TODO: ![version](https://img.shields.io/gem/v/#{Gem.name}?label=) -->

    TODO: gem description here

    <!-- TODO:
    - Gem: [rubygems.org](https://rubygems.org/gems/#{Gem.name})
    - Source: [github.com](https://github.com/mblumtritt/#{Gem.name})
    - Help: [rubydoc.info](https://rubydoc.info/gems/#{Gem.name}/#{Gem.module})
    -->

    ## Description

    TODO: more here

    ## Installation

    You can install the gem in your system with

    ```shell
    gem install #{Gem.name}
    ```

    or you can use [Bundler](http://gembundler.com/) to add #{Gem.module} to your own project:

    ```shell
    bundle add '#{Gem.name}'
    ```

    After that you only need one line of code to have everything together

    ```ruby
    require '#{Gem.name}'
    ```
  README
end

file_create 'stats.md' do |f|
  write f.name, <<~STATS
    # Gem/Repo Statistics

    ![version](https://img.shields.io/gem/v/#{Gem.name})
    ![downloads](https://img.shields.io/gem/dt/#{Gem.name})
    ![downloads](https://img.shields.io/gem/dtv/#{Gem.name})

    ![license](https://img.shields.io/github/license/mblumtritt/#{Gem.name})
    ![stars](https://img.shields.io/github/stars/mblumtritt/#{Gem.name})
    ![watchers](https://img.shields.io/github/watchers/mblumtritt/#{Gem.name})
    ![forks](https://img.shields.io/github/forks/mblumtritt/#{Gem.name})

    ![issues](https://img.shields.io/github/issues/mblumtritt/#{Gem.name})
    ![closed issues](https://img.shields.io/github/issues-closed/mblumtritt/#{Gem.name})
    ![pull-requests](https://img.shields.io/github/issues-pr/mblumtritt/#{Gem.name})
    ![closed pull-requests](https://img.shields.io/github/issues-pr-closed/mblumtritt/#{Gem.name})

    ![last commit](https://img.shields.io/github/last-commit/mblumtritt/#{Gem.name}/main)
    ![files](https://img.shields.io/github/directory-file-count/mblumtritt/#{Gem.name})
    ![dependencies](https://img.shields.io/librariesio/github/mblumtritt/#{Gem.name})

    ![commit activity](https://img.shields.io/github/commit-activity/m/mblumtritt/#{Gem.name})
  STATS
end

file_create '.yardopts' do |f|
  write f.name, <<~YARDOPTS
    --readme README.md
    --title 'TODO: Documentation'
    --charset utf-8
    --markup markdown
    --tag comment
    --hide-tag comment
    'lib/**/*.rb' - 'README.md'
  YARDOPTS
end

file_create 'spec/helper.rb' do |f|
  write f.name, <<~HELPER
    # frozen_string_literal: true

    require 'rspec/core'
    require_relative '../lib/#{Gem.name}'

    $stdout.sync = $stderr.sync = $VERBOSE = true
    RSpec.configure(&:disable_monkey_patching!)
  HELPER
end

file_create "spec/#{Gem.name}_spec.rb" => 'spec/helper.rb' do |f|
  write f.name, <<~SPEC
    # frozen_string_literal: true

    require_relative 'helper'

    RSpec.describe #{Gem.module} do
      xit do
        # TODO: describe your module here
      end
    end
  SPEC
end

file_create "spec/#{Gem.name}/version_spec.rb" => 'spec/helper.rb' do |f|
  write f.name, <<~VERSION_SPEC
    # frozen_string_literal: true

    require_relative '../helper'

    RSpec.describe '#{Gem.module}::VERSION' do
      subject(:version) { #{Gem.module}::VERSION }

      it { is_expected.to be_frozen }
      it do
        is_expected.to match(
          /\\A[[:digit:]]{1,3}.[[:digit:]]{1,3}.[[:digit:]]{1,3}(alpha|beta)?\\z/
        )
      end
    end
  VERSION_SPEC
end

file_create "lib/#{Gem.name}.rb" => "spec/#{Gem.name}_spec.rb" do |f|
  write f.name, <<~SOURCE
    # frozen_string_literal: true

    module #{Gem.module}
      # TODO: add code here
    end
  SOURCE
end

file_create "lib/#{Gem.name}/version.rb" => %W[
              lib/#{Gem.name}.rb
              spec/#{Gem.name}/version_spec.rb
            ] do |f|
  write f.name, <<~VERSION
    # frozen_string_literal: true

    module #{Gem.module}
      # @return [String] the version number of the gem
      VERSION = '0.1.0alpha'
    end
  VERSION
end

file_create "#{Gem.name}.gemspec" => "lib/#{Gem.name}/version.rb" do |f|
  write f.name, <<~GEMSPEC
    # frozen_string_literal: true

    require_relative 'lib/#{Gem.name}/version'

    Gem::Specification.new do |spec|
      spec.name = '#{Gem.name}'
      spec.version = #{Gem.module}::VERSION
      spec.summary = 'The new gem #{Gem.module}.'
      spec.description = <<~DESCRIPTION
        A helpful and catchy description is missing here!
      DESCRIPTION

      spec.author = 'Mike Blumtritt'
      # spec.license = 'BSD-3-Clause'
      spec.homepage = 'https://github.com/mblumtritt/#{Gem.name}'
      spec.metadata['source_code_uri'] = spec.homepage
      spec.metadata['bug_tracker_uri'] = "\#{spec.homepage}/issues"
      spec.metadata['documentation_uri'] = 'https://rubydoc.info/gems/#{Gem.name}'
      spec.metadata['rubygems_mfa_required'] = 'true'

      spec.required_ruby_version = '>= 3.0'
      # spec.add_runtime_dependency 'TODO: add dependencies'

      spec.files = Dir['lib/**/*']
      # spec.executables = %w[command]
      # spec.extra_rdoc_files = %w[README.md LICENSE]
    end
  GEMSPEC
end

file_create 'Gemfile' do |f|
  content = <<~GEMFILE
    # frozen_string_literal: true

    source 'https://rubygems.org'

    group :development, :test do
      gem 'bundler', require: false
      gem 'rake', require: false
    end
  GEMFILE

  content += <<~GEMFILE if File.directory?('spec')

    group :test do
      gem 'rspec', require: false
    end
  GEMFILE

  content += <<~GEMFILE if File.file?('.yardopts')

    group :development do
      gem 'webrick', require: false
      gem 'yard', require: false
    end
  GEMFILE

  content += <<~GEMFILE if File.file?("#{Gem.name}.gemspec")

    gemspec
  GEMFILE

  write f.name, content
end

file_create 'Gemfile.lock' => 'Gemfile' do |f|
  sh 'bundle update'
end

file_create 'Rakefile' do |f|
  content = <<~RAKEFILE
    # frozen_string_literal: true

    $stdout.sync = $stderr.sync = true
  RAKEFILE

  content += <<~RAKEFILE if File.file?("#{Gem.name}.gemspec")

    require 'bundler/gem_tasks'

    require 'rspec/core/rake_task'
    RSpec::Core::RakeTask.new(:test) { |t| t.ruby_opts = %w[-w] }
  RAKEFILE

  content += <<~RAKEFILE if File.file?('.yardopts')

    require 'yard'

    CLEAN << '.yardoc'
    CLOBBER << 'doc'

    YARD::Rake::YardocTask.new(:doc) { |t| t.stats_options = %w[--list-undoc] }

    desc 'Run YARD development server'
    task('doc:dev' => :clobber) { exec('yard server --reload') }
  RAKEFILE

  content += <<~RAKEFILE

    task(:default) { exec('rake --tasks') }
  RAKEFILE

  write f.name, content
end
