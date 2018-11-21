# frozen_string_literal: true

desc 'create default Rakefile'
task rakefile: './rakefile.rb'

rule %r(rakefile.rb$) do |r|
  write r.name, <<~RAKEFILE
    # frozen_string_literal: true

    STDOUT.sync = STDERR.sync = true

    task :default do
      exec "\#{$PROGRAM_NAME} --tasks"
    end
  RAKEFILE
end
