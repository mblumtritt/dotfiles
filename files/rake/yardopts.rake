# frozen_string_literal: true

file_create '.yardopts' => 'README.md' do |f|
  write f.name, <<~YARDOPTS
    --readme README.md
    --title 'TODO: Documentation'
    --charset utf-8
    --markup markdown
    'lib/**/*.rb' - 'README.md'
  YARDOPTS
end
