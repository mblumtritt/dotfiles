# frozen_string_literal: true

file_create '.git/HEAD' do
  sh 'git init -b main .'
end

file_create '.gitignore' => '.git/HEAD' do |f|
  write f.name, <<~GITIGNORE
    tmp/
    pkg/
    local/
    doc/
    .yardoc/
    Gemfile.lock
  GITIGNORE
end
