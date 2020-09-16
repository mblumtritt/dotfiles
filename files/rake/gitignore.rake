# frozen_string_literal: true

desc 'create default .gitignore file'
task gitignore: '.gitignore'

rule '.gitignore' do |r|
  write r.name, <<~GITIGNORE
    idea/
    local/
    tmp/
    pkg/
    gems.locked
  GITIGNORE
end
