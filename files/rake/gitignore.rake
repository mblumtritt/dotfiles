desc 'create default .gitignore file'
task gitignore: '.gitignore'

rule '.gitignore' do |r|
  write r.name, <<~EOF
    idea/
    tmp/
    pkg/
    gems.locked
  EOF
end
