# frozen_string_literal: true

desc 'create default .gitignore file'
task gitignore: '.gitignore'

rule '.gitignore' do |r|
  write r.name, <<~gitignore
    tmp/
    pkg/
    local/
    doc/
    .yardoc/
    Gemfile.lock
  gitignore
end
