desc 'create default Rakefile'
task rakefile: './Rakefile'

rule %r(Rakefile$) do |r|
  write r.name, <<-EOF
    STDOUT.sync = STDERR.sync = true
  EOF
end
