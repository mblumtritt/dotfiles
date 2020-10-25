# frozen_string_literal: true

desc 'create default gemspec file'
task gemspec: "#{File.basename(File.expand_path('./'))}.gemspec"

rule '.gemspec' do |r|
  write r.name, Gemspec.for(r.name)
end

module Gemspec
  def self.present?(dirname)
    !Dir[File.join(dirname, '*.gemspec')].empty?
  end

  def self.basename(file_path)
    File.dirname(File.expand_path(file_path)).split('/').last
  end

  def self.gemname(file_path)
    basename(file_path).split(%r([-_])).map!(&:capitalize).join
  end

  def self.for(file_path)
    content(basename(file_path), gemname(file_path))
  end

  def self.content(basename, gemname)
    <<~CONTENT
      # frozen_string_literal: true

      require_relative './lib/#{basename}/version'

      Gem::Specification.new do |spec|
        spec.name = '#{basename}'
        spec.version = #{gemname}::VERSION
        spec.author = 'Mike Blumtritt'

        spec.required_ruby_version = '>= 2.7.0'

        spec.summary = 'The new gem #{gemname}.'
        spec.description = spec.summary
        spec.homepage = 'https://github.com/mblumtritt/#{basename}'

        spec.metadata['source_code_uri'] =
          'https://github.com/mblumtritt/#{basename}'
        spec.metadata['bug_tracker_uri'] =
          'https://github.com/mblumtritt/#{basename}/issues'

        # spec.add_runtime_dependency 'TODO'

        spec.add_development_dependency 'bundler'
        spec.add_development_dependency 'rake'
        spec.add_development_dependency 'minitest'

        all_files = Dir.chdir(__dir__) { `git ls-files -z`.split(0.chr) }
        spec.test_files = all_files.grep(%r{^(spec|test)/})
        spec.files = all_files - spec.test_files
        # spec.executables = all_files.grep(%r{^bin/}){ |n| File.basename(n) }
        # spec.extra_rdoc_files = %w[README.md]
      end
    CONTENT
  end
end
