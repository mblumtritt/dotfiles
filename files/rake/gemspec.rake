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
    basename(file_path).split(/[-_]/).map!(&:capitalize).join
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
        spec.summary = 'The new gem #{gemname}.'
        spec.description = <<~DESCRIPTION
          Todo: write a helpful and catchy description
        DESCRIPTION

        spec.author = 'Mike Blumtritt'
        # spec.license = 'BSD-3-Clause'
        spec.homepage = 'https://github.com/mblumtritt/#{basename}'
        spec.metadata = {
          'source_code_uri' => spec.homepage,
          'bug_tracker_uri' => "#\{spec.homepage\}/issues",
        }

        spec.files = Dir['lib/**/*']
        # spec.executables = Dir['bin/*']
        spec.required_ruby_version = '>= 2.7.0'
        # spec.add_runtime_dependency 'TODO'

        # spec.rdoc_options += [
        #   '--title',
        #   '#{basename} Documentation',
        #   '--main',
        #   'README.md',
        #   '--line-numbers',
        #   '--inline-source',
        #   '--quiet'
        # ]
        # spec.extra_rdoc_files = %w[README.md LICENSE]
      end
    CONTENT
  end
end
