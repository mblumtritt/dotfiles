#! /bin/sh

set -e

(command -v code >/dev/null 2>&1) && {
  echo 'install: VSCode extensions'

  code --install-extension --force  adpyke.vscode-sql-formatter
  code --install-extension --force  akamud.vscode-theme-onelight
  code --install-extension --force  andys8.jest-snippets
  code --install-extension --force  ban.spellright
  code --install-extension --force  bmalehorn.shell-syntax
  code --install-extension --force  christian-kohler.npm-intellisense
  code --install-extension --force  christian-kohler.path-intellisense
  code --install-extension --force  christianoetterli.refactorix
  code --install-extension --force  dbaeumer.vscode-eslint
  code --install-extension --force  esbenp.prettier-vscode
  code --install-extension --force  formulahendry.code-runner
  code --install-extension --force  GitHub.copilot
  code --install-extension --force  GitHub.copilot-chat
  code --install-extension --force  hbenl.vscode-test-explorer
  code --install-extension --force  infeng.vscode-react-typescript
  code --install-extension --force  jasonnutter.search-node-modules
  code --install-extension --force  kavod-io.vscode-jest-test-adapter
  code --install-extension --force  misogi.ruby-rubocop
  code --install-extension --force  ms-vscode.cmake-tools
  code --install-extension --force  ms-vscode.cpptools
  code --install-extension --force  ms-vscode.cpptools-extension-pack
  code --install-extension --force  ms-vscode.cpptools-themes
  code --install-extension --force  ms-vscode.test-adapter-converter
  code --install-extension --force  Orta.vscode-jest
  code --install-extension --force  rebornix.ruby
  code --install-extension --force  ruby-syntax-tree.vscode-syntax-tree
  code --install-extension --force  scrapecrow.html-escape
  code --install-extension --force  Thadeu.vscode-run-rspec-file
  code --install-extension --force  timonwong.shellcheck
  code --install-extension --force  undefined_publisher.mike
  code --install-extension --force  wingrunr21.vscode-ruby
}
