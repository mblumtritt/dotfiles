# frozen_string_literal: true

file_create('.git/HEAD') { sh 'git init -b main .' }

file_create('.gitignore' => '.git/HEAD') { |f| write f.name, <<~GITIGNORE }
  tmp/
  pkg/
  local/
  doc/
  .yardoc/
  .vscode/
  *.lock
  .rubocop.*
GITIGNORE
