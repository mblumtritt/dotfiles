# frozen_string_literal: true

module ThisGem
  class << self
    attr_reader :name, :module

    def rubygems = "https://rubygems.org/gems/#{name}"
    def github = "https://github.com/mblumtritt/#{name}"
    def rubydoc = "https://rubydoc.info/gems/#{name}/#{self.module}"
    def shield(which) = "https://img.shields.io/#{which}/#{name}"
    def gh_shield(which) = shield("github/#{which}/mblumtritt")
  end

  @name = (ENV['NAME'] || File.basename(Dir.pwd)).freeze
  @module = @name.split(/[-_]/).map!(&:capitalize).join.freeze
end

desc "Create structure for gem '#{ThisGem.name}' in './'"
task(
  gem: %W[
    .gitignore
    .yardopts
    #{ThisGem.name}.gemspec
    Gemfile.lock
    Rakefile
    README.md
    stats.md
  ]
) { exec('bundle exec rake test') }

file_create('README.md') { write _1.name, <<~README }
  # #{ThisGem.module}
  <!-- TODO: ![version](https://img.shields.io/gem/v/#{ThisGem.name}?label=) -->

  TODO: gem description here

  <!-- TODO:
  - #{ThisGem.module}: [rubygems.org](#{ThisGem.rubygems})
  - Source: [github.com](#{ThisGem.github})
  - Help: [rubydoc.info](#{ThisGem.rubydoc})
  -->

  ## Description

  TODO: more here

  ## Installation

  You can install the gem in your system with

  ```shell
  gem install #{ThisGem.name}
  ```

  or you can use [Bundler](http://gembundler.com/) to add #{ThisGem.module} to your own project:

  ```shell
  bundle add #{ThisGem.name}
  ```

  After that you only need one line of code to have everything together

  ```ruby
  require '#{ThisGem.name}'
  ```
README

file_create('stats.md') { write _1.name, <<~STATS }
  # #{ThisGem.module} Statistics

  [![version](#{ThisGem.shield('gem/v')})](#{ThisGem.rubygems})
  [![downloads](#{ThisGem.shield('gem/dt')})](#{ThisGem.rubygems})
  [![downloads](#{ThisGem.shield('gem/dtv')})](#{ThisGem.rubygems})

  ![license](#{ThisGem.gh_shield(:license)})

  [![dependencies](https://img.shields.io/librariesio/github/mblumtritt/#{ThisGem.name})](#{ThisGem.github}/network/dependencies)

  ![last commit](#{ThisGem.gh_shield('last-commit')}/main)
  ![commit activity](#{ThisGem.gh_shield('commit-activity/m')})

  [![issues](#{ThisGem.gh_shield(:issues)})](#{ThisGem.github}/issues)
  [![pull-requests](#{ThisGem.gh_shield('issues-pr')})](#{ThisGem.github}/pulls)

  [![stars](#{ThisGem.gh_shield(:stars)})](#{ThisGem.github}/stargazers)
  [![watchers](#{ThisGem.gh_shield(:watchers)})](#{ThisGem.github}/watchers)
  [![forks](#{ThisGem.gh_shield(:forks)})](#{ThisGem.github}/forks)
STATS

file_create('.yardopts') { write _1.name, <<~YARDOPTS }
  --title '#{ThisGem.name}'
  --charset utf-8
  --markup markdown
  --readme README.md
  --no-private
  --embed-mixins
  --tag comment
  --hide-tag comment
  lib/**/*.rb
  -
  README.md
YARDOPTS

file_create('.rspec') { write _1.name, <<~RSPEC }
  --require helper
RSPEC

file_create('spec/helper.rb' => '.rspec') { write _1.name, <<~HELPER }
  # frozen_string_literal: true

  require_relative '../lib/#{ThisGem.name}'

  $stdout.sync = $stderr.sync = $VERBOSE = Warning[:deprecated] = true
  RSpec.configure(&:disable_monkey_patching!)
HELPER

file_create("spec/lib/#{ThisGem.name}_spec.rb" => 'spec/helper.rb') do |f|
  write f.name, <<~SPEC
    # frozen_string_literal: true

    RSpec.describe #{ThisGem.module} do
      xit do
        # TODO: describe your module here
      end
    end
  SPEC
end

file_create(
  "spec/lib/#{ThisGem.name}/version_spec.rb" => 'spec/helper.rb'
) { |f| write f.name, <<~VERSION_SPEC }
  # frozen_string_literal: true

  RSpec.describe '#{ThisGem.module}::VERSION' do
    subject(:version) { #{ThisGem.module}::VERSION }

    it { is_expected.to be_frozen }

    it do
      is_expected.to match(
        /\\A[[:digit:]]{1,3}.[[:digit:]]{1,3}.[[:digit:]]{1,3}(alpha|beta)?\\z/
      )
    end
  end
VERSION_SPEC

file_create(
  "lib/#{ThisGem.name}.rb" => "spec/lib/#{ThisGem.name}_spec.rb"
) { |f| write f.name, <<~SOURCE }
  # frozen_string_literal: true

  module #{ThisGem.module}
    # TODO: add code here
  end
SOURCE

file_create(
  "lib/#{ThisGem.name}/version.rb" => %W[
    lib/#{ThisGem.name}.rb
    spec/lib/#{ThisGem.name}/version_spec.rb
  ]
) { write _1.name, <<~VERSION }
  # frozen_string_literal: true

  module #{ThisGem.module}
    # The version number of the gem.
    VERSION = '0.1.0alpha'
  end
VERSION

file_create(
  "#{ThisGem.name}.gemspec" => "lib/#{ThisGem.name}/version.rb"
) { |f| write f.name, <<~GEMSPEC }
  # frozen_string_literal: true

  require_relative 'lib/#{ThisGem.name}/version'

  Gem::Specification.new do |spec|
    spec.name = '#{ThisGem.name}'
    spec.version = #{ThisGem.module}::VERSION
    spec.summary = 'TODO: #{ThisGem.module}.'
    spec.description = <<~DESCRIPTION
      TODO: A helpful and catchy description is missing here!
    DESCRIPTION

    spec.author = 'Mike Blumtritt'
    # TODO: spec.license = 'BSD-3-Clause'
    spec.homepage = 'https://github.com/mblumtritt/#{ThisGem.name}'
    spec.metadata['source_code_uri'] = spec.homepage
    spec.metadata['bug_tracker_uri'] = "\#{spec.homepage}/issues"
    spec.metadata['documentation_uri'] = 'https://rubydoc.info/gems/#{ThisGem.name}'
    spec.metadata['rubygems_mfa_required'] = 'true'

    spec.required_ruby_version = '>= 3.0'
    # TODO: spec.add_dependency 'add dependencies here'

    spec.files = Dir['lib/**/*']
    # TODO: spec.executables = %w[command]
    spec.extra_rdoc_files = %w[README.md]
  end
GEMSPEC

file_create('Gemfile') do |f|
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

  content += <<~GEMFILE if File.file?("#{ThisGem.name}.gemspec")

    gemspec
  GEMFILE

  write f.name, content
end

file_create('Gemfile.lock' => 'Gemfile') { sh 'bundle update' }

file_create('Rakefile') do |f|
  content = <<~RAKEFILE
    # frozen_string_literal: true

    $stdout.sync = $stderr.sync = true
  RAKEFILE

  content += <<~RAKEFILE if File.file?("#{ThisGem.name}.gemspec")

    require 'bundler/gem_tasks'

    require 'rspec/core/rake_task'
    RSpec::Core::RakeTask.new(:test) { _1.ruby_opts = %w[-w] }
  RAKEFILE

  content += <<~RAKEFILE if File.file?('.yardopts')

    require 'yard'

    CLEAN << '.yardoc'
    CLOBBER << 'doc'

    YARD::Rake::YardocTask.new(:doc) { _1.stats_options = %w[--list-undoc] }

    desc 'Run YARD development server'
    task('doc:dev' => :clobber) { exec 'yard server --reload' }
  RAKEFILE

  content += <<~RAKEFILE

    task(:default) { exec 'rake --tasks' }
  RAKEFILE

  write f.name, content
end
