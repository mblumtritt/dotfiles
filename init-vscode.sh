#! /bin/sh

set -e

echo 'Install Path Intellisense Extensions'
code --install-extension christian-kohler.path-intellisense

echo 'Install Code Runner'
code --install-extension formulahendry.code-runner

echo 'Install Shell Sccript extensions'
code --install-extension bmalehorn.shell-syntax
code --install-extension timonwong.shellcheck

echo 'Install tester Extensions'
code --install-extension ms-vscode.test-adapter-converter
code --install-extension hbenl.vscode-test-explorer

echo 'Install C++ Extensions'
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.cpptools-extension-pack
code --install-extension ms-vscode.cpptools-themes
code --install-extension twxs.cmake
code --install-extension ms-vscode.cmake-tools

echo 'Install Docker Extensions'
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode-remote.remote-containers

echo 'Install JS Linter/Prettier Extensions'
code --install-extension esbenp.prettier-vscode

echo 'Install TypeScript Extensions'
code --install-extension christianoetterli.refactorix
code --install-extension infeng.vscode-react-typescript

echo 'Install npm Extensions'
code --install-extension christian-kohler.npm-intellisense
code --install-extension jasonnutter.search-node-modules

echo 'Install Jest Extensions'
code --install-extension Orta.vscode-jest
code --install-extension andys8.jest-snippets
code --install-extension kavod-io.vscode-jest-test-adapter

echo 'Install Ruby Extensions'
code --install-extension wingrunr21.vscode-ruby
code --install-extension rebornix.ruby
code --install-extension misogi.ruby-rubocop
code --install-extension Thadeu.vscode-run-rspec-file

echo 'Install SQL Extensions'
code --install-extension adpyke.vscode-sql-formatter

