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

      GemSpec =
        Gem::Specification.new do |gem|
          gem.name = '#{basename}'
          gem.version = #{gemname}::VERSION
          gem.summary = 'The new gem #{gemname}.'
          gem.description = gem.summary
          gem.author = 'Mike Blumtritt'
          gem.homepage = 'https://github.com/mblumtritt/#{basename}'
          gem.metadata = {
            'source_code_uri' => 'https://github.com/mblumtritt/#{basename}',
            'bug_tracker_uri' => 'https://github.com/mblumtritt/#{basename}/issues'
          }

          gem.required_ruby_version = '>= 2.7.0'

          # gem.add_runtime_dependency 'TODO'

          gem.add_development_dependency 'bundler'
          gem.add_development_dependency 'rake'
          gem.add_development_dependency 'minitest'

          all_files = %x(git ls-files -z).split(0.chr)
          gem.test_files = all_files.grep(%r{^(spec|test)/})
          gem.files = all_files - gem.test_files
          # gem.executables = all_files.grep(%r{^bin/}){ |n| File.basename(n) }
          # gem.extra_rdoc_files = %w[README.MD]
        end
    CONTENT
  end
end
