desc 'create default gemspec file'
task gemspec: "#{File.basename(File.expand_path('./'))}.gemspec"

rule '.gemspec' do |r|
  basename  = File.basename(r.name, '.gemspec')
  gemname = basename.split(%r([-_])).map!(&:capitalize).join
  File.file?("./lib/#{basename}/version.rb") or fail 'file not found - version.rb'
  content = <<~EOF
    # frozen_string_literal: true

    require File.expand_path('../lib/#{basename}/version', __FILE__)

    GemSpec = Gem::Specification.new do |spec|
      spec.name = '#{basename}'
      spec.version = #{gemname}::VERSION
      spec.summary = 'The new gem #{gemname}.'
      spec.description = spec.summary
      spec.author = 'Mike Blumtritt'
      spec.email = 'mike.blumtritt@invision.de'
      spec.homepage = 'https://github.com/mblumtritt/#{basename}'
      spec.metadata = {'issue_tracker' => 'https://github.com/mblumtritt/#{basename}/issues'}
      spec.rubyforge_project = spec.name

      # spec.add_runtime_dependency 'todo'
      spec.add_development_dependency 'bundler'
      spec.add_development_dependency 'rake'

      spec.platform = Gem::Platform::RUBY
      spec.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
      spec.required_ruby_version = '>= 2.5.0'

      spec.require_paths = %w[lib]
      # spec.bindir = 'bin'
      # spec.executables = %w[#{basename}]

      all_files = %x(git ls-files -z).split(0.chr)
      spec.test_files = all_files.grep(%r{^(spec|test)/})
      spec.files = all_files - spec.test_files

      spec.has_rdoc = false
      spec.extra_rdoc_files = %w[README.md]
    end
  EOF
  write r.name, content
end
