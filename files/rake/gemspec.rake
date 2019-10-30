# frozen_string_literal: true

desc 'create default gemspec file'
task gemspec: "#{File.basename(File.expand_path('./'))}.gemspec"

rule '.gemspec' do |r|
  basename  = File.basename(r.name, '.gemspec')
  gemname = basename.split(%r([-_])).map!(&:capitalize).join
  File.file?("./lib/#{basename}/version.rb") or fail 'file not found - version.rb'
  write r.name, <<~GEMSPEC
    # frozen_string_literal: true

    require_relative './lib/#{basename}/version'

    GemSpec = Gem::Specification.new do |gem|
      gem.name = gem.rubyforge_project = '#{basename}'
      gem.version = #{gemname}::VERSION
      gem.summary = 'The new gem #{gemname}.'
      gem.description = gem.summary
      gem.author = 'Mike Blumtritt'
      gem.email = 'mike.blumtritt@invision.de'
      gem.homepage = 'https://github.com/mblumtritt/#{basename}'
      gem.metadata = {
        'source_code_uri' => 'https://github.com/mblumtritt/#{basename}',
        'bug_tracker_uri' => 'https://github.com/mblumtritt/#{basename}/issues'
      }

      # gem.add_runtime_dependency 'todo'
      gem.add_development_dependency 'bundler'
      gem.add_development_dependency 'rake'

      gem.platform = Gem::Platform::RUBY
      gem.required_ruby_version = '>= 2.5.0'
      gem.required_rubygems_version = '>= 1.3.6'

      gem.require_paths = %w[lib]
      # gem.bindir = 'bin'
      # gem.executables = %w[#{basename}]

      all_files = %x(git ls-files -z).split(0.chr)
      gem.test_files = all_files.grep(%r{^(spec|test)/})
      gem.files = all_files - gem.test_files

      # gem.extra_rdoc_files = %w[README.MD]
    end
  GEMSPEC
end
