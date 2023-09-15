# frozen_string_literal: true

require_relative 'prj'

directory 'lib'
directory "lib/#{Prj.name}"

file_create "lib/#{Prj.name}.rb" => 'lib' do |f|
  write f.name, <<~CONTENT
    # frozen_string_literal: true

    module #{Prj.module}
      # TODO: add code here
    end
  CONTENT
end

file_create "lib/#{Prj.name}/version.rb" => "lib/#{Prj.name}" do |f|
  write f.name, <<~VERSION
    # frozen_string_literal: true

    module #{Prj.module}
      # @return [String] the version number of the gem
      VERSION = '0.1.0'
    end
  VERSION
end
