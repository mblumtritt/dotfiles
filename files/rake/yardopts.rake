# frozen_string_literal: true

desc 'create default YARD options file'
task yardopts: './.yardopts'

rule /.yardopts$/ do |r|
  write r.name, <<~yardopts
    --readme README.md
    --title 'TODO Documentation'
    --charset utf-8
    --markup markdown
    'lib/**/*.rb' - 'LICENSE'
  yardopts
end
