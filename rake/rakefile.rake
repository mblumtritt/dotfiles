desc 'create default Rakefile'
task rakefile: './rakefile.rb'

rule %r(rakefile.rb$) do |r|
  write r.name, <<~EOF
    STDOUT.sync = STDERR.sync = true

    task :default do
      exec('rake -T')
    end
  EOF
end
