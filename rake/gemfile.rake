desc 'create default Gemfile'
task gemfile: './Gemfile'

rule %r(Gemfile$) do |r|
  content = if Dir['*.gemspec'].empty?
    <<-EOF
      source 'https://rubygems.org' do
        gem 'bundler', '>= 1.12.5'
        gem 'rake', '>= 11.1.2'
      end
    EOF
  else
    <<-EOF
      source 'https://rubygems.org' do
        gemspec
      end
    EOF
  end
  write r.name, content
end
