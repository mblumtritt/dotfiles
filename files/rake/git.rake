# frozen_string_literal: true

file_create('.git/HEAD') { sh 'git init -b main .' }

file_create('.gitignore' => '.git/HEAD') { write _1.name, <<~GITIGNORE }
  tmp/
  pkg/
  doc/
  .rubocop.yml
GITIGNORE
