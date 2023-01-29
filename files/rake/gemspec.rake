# frozen_string_literal: true

require_relative 'prj'

file_create "#{Prj.name}.gemspec" => "lib/#{Prj.name}/version.rb" do |f|
  write f.name, <<~CONTENT
    # frozen_string_literal: true

    require_relative './lib/#{Prj.name}/version'

    Gem::Specification.new do |spec|
      spec.name = '#{Prj.name}'
      spec.version = #{Prj.module}::VERSION
      spec.summary = 'The new gem #{Prj.module}.'
      spec.description = <<~DESCRIPTION
        Todo: write a helpful and catchy description
      DESCRIPTION

      spec.author = 'Mike Blumtritt'
      # spec.license = 'BSD-3-Clause'
      spec.homepage = 'https://github.com/mblumtritt/#{Prj.name}'
      spec.metadata['source_code_uri'] = spec.homepage
      spec.metadata['bug_tracker_uri'] = "\#{spec.homepage}/issues"
      spec.metadata['documentation_uri'] = 'https://rubydoc.info/gems/#{Prj.name}'
      spec.metadata['rubygems_mfa_required'] = 'true'

      spec.required_ruby_version = '>= 3.0.0'
      # spec.add_runtime_dependency 'TODO: add dependency'

      spec.files = Dir['lib/**/*']
      # spec.executables = %w[command]
      # spec.extra_rdoc_files = %w[README.md LICENSE]
    end
  CONTENT
end
