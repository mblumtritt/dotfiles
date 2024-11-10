# frozen_string_literal: true

module ThisGem
  class << self
    attr_reader :name, :module
  end

  @name = (ENV['NAME'] || File.basename(Dir.pwd)).freeze
  @module = @name.split(/[-_]/).map!(&:capitalize).join.freeze
end

desc "Create structure for gem '#{ThisGem.name}' in './'"
task(
  gem: %W[
    #{ThisGem.name}.gemspec
    .yardopts
    Gemfile.lock
    Rakefile
    README.md
    stats.md
    .gitignore
  ]
) { exec('bundle exec rake test') }

file_create('README.md') { |f| write f.name, <<~README }
  # #{ThisGem.module}
  <!-- TODO: ![version](https://img.shields.io/gem/v/#{ThisGem.name}?label=) -->

  TODO: gem description here

  <!-- TODO:
  - ThisGem: [rubygems.org](https://rubygems.org/gems/#{ThisGem.name})
  - Source: [github.com](https://github.com/mblumtritt/#{ThisGem.name})
  - Help: [rubydoc.info](https://rubydoc.info/gems/#{ThisGem.name}/#{ThisGem.module})
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

file_create('stats.md') { |f| write f.name, <<~STATS }
  # ThisGem/Repo Statistics

  ![version](https://img.shields.io/gem/v/#{ThisGem.name})
  ![downloads](https://img.shields.io/gem/dt/#{ThisGem.name})
  ![downloads](https://img.shields.io/gem/dtv/#{ThisGem.name})

  ![license](https://img.shields.io/github/license/mblumtritt/#{ThisGem.name})
  ![stars](https://img.shields.io/github/stars/mblumtritt/#{ThisGem.name})
  ![watchers](https://img.shields.io/github/watchers/mblumtritt/#{ThisGem.name})
  ![forks](https://img.shields.io/github/forks/mblumtritt/#{ThisGem.name})

  ![issues](https://img.shields.io/github/issues/mblumtritt/#{ThisGem.name})
  ![closed issues](https://img.shields.io/github/issues-closed/mblumtritt/#{ThisGem.name})
  ![pull-requests](https://img.shields.io/github/issues-pr/mblumtritt/#{ThisGem.name})
  ![closed pull-requests](https://img.shields.io/github/issues-pr-closed/mblumtritt/#{ThisGem.name})

  ![last commit](https://img.shields.io/github/last-commit/mblumtritt/#{ThisGem.name}/main)
  ![files](https://img.shields.io/github/directory-file-count/mblumtritt/#{ThisGem.name})
  ![dependencies](https://img.shields.io/librariesio/github/mblumtritt/#{ThisGem.name})

  ![commit activity](https://img.shields.io/github/commit-activity/m/mblumtritt/#{ThisGem.name})
STATS

file_create('.yardopts') { |f| write f.name, <<~YARDOPTS }
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

file_create('.rspec') { |f| write f.name, <<~RSPEC }
  --require helper
RSPEC

file_create('spec/helper.rb' => '.rspec') { |f| write f.name, <<~HELPER }
  # frozen_string_literal: true

  require_relative '../lib/#{ThisGem.name}'

  $stdout.sync = $stderr.sync = $VERBOSE = true
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
) { |f| write f.name, <<~VERSION }
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

  ThisGem::Specification.new do |spec|
    spec.name = '#{ThisGem.name}'
    spec.version = #{ThisGem.module}::VERSION
    spec.summary = 'The new gem #{ThisGem.module}.'
    spec.description = <<~DESCRIPTION
      A helpful and catchy description is missing here!
    DESCRIPTION

    spec.author = 'Mike Blumtritt'
    # spec.license = 'BSD-3-Clause'
    spec.homepage = 'https://github.com/mblumtritt/#{ThisGem.name}'
    spec.metadata['source_code_uri'] = spec.homepage
    spec.metadata['bug_tracker_uri'] = "\#{spec.homepage}/issues"
    spec.metadata['documentation_uri'] = 'https://rubydoc.info/gems/#{ThisGem.name}'
    spec.metadata['rubygems_mfa_required'] = 'true'

    spec.required_ruby_version = '>= 3.0'
    # spec.add_dependency 'TODO: add dependencies'

    spec.files = Dir['lib/**/*']
    # spec.executables = %w[command]
    # spec.extra_rdoc_files = %w[README.md LICENSE]
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
