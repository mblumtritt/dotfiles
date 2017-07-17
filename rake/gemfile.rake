desc 'create default Gemfile'
task gemfile: './Gemfile'

rule %r(Gemfile$) do |r|
  content = if Dir['*.gemspec'].empty?
    <<~EOF
      source 'https://rubygems.org' do
        gem 'bundler'
        gem 'rake'
      end
    EOF
  else
    <<~EOF
      source 'https://rubygems.org' do
        gemspec
      end
    EOF
  end
  write r.name, content
end
