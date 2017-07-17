desc 'create default .gitignore file'
task gitignore: '.gitignore'

rule '.gitignore' do |r|
  write r.name, <<~EOF
    tmp/
    local/
    pkg/
  EOF
end
