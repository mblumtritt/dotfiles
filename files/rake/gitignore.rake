# frozen_string_literal: true

desc 'create default .gitignore file'
task gitignore: '.gitignore'

rule '.gitignore' do |r|
  write r.name, <<~GITIGNORE
    tmp/
    log/
    pkg/
    local/
    gems.locked
  GITIGNORE
end
