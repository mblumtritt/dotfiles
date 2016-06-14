desc 'create default gemspec file'
task gemspec: "#{File.basename(File.expand_path('./'))}.gemspec"

rule '.gemspec' do |r|
  basename  = File.basename(r.name, '.gemspec')
  gemname = basename.split(%r([-_])).map!(&:capitalize).join
  File.file?("./lib/#{basename}/version.rb") or fail 'file not found - version.rb'
  content = <<-EOF
    require File.expand_path('../lib/#{basename}/version', __FILE__)

    FILES = %x(git ls-files).split($/)
    GemSpec = Gem::Specification.new do |spec|
      spec.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
      spec.platform = Gem::Platform::RUBY
      spec.required_ruby_version = '>= 2.0.0'
      spec.name = spec.rubyforge_project = '#{basename}'
      spec.version = #{gemname}::VERSION
      spec.summary = 'The new gem #{gemname}.'
      spec.description = %w(
        This gem has no description yet.
      ).join(' ')
      spec.author = 'Mike Blumtritt'
      spec.email = 'mike.blumtritt@invision.de'
      spec.homepage = 'https://github.com/mblumtritt/#{basename}'
      spec.metadata = {
        'issue_tracker' => 'https://github.com/mblumtritt/#{basename}/issues'
      }
      spec.require_paths = %w(lib)
      spec.test_files = FILES.grep(%r{^(spec|test)/})
      spec.files = FILES - spec.test_files
      spec.has_rdoc = false
      spec.extra_rdoc_files = %w(README.md CHANGELOG.md)
      spec.add_development_dependency 'bundler', '~> 1.12'
      spec.add_development_dependency 'rake', '~> 11.2'
    end
  EOF
  write r.name, content
end
