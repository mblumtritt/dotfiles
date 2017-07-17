desc 'create default Rakefile'
task rakefile: './rakefile'

rule %r(rakefile$) do |r|
  write r.name, <<~EOF
    STDOUT.sync = STDERR.sync = true

    task :default do
      exec('rake -T')
    end
  EOF
end
