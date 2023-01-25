# frozen_string_literal: true

require_relative 'prj'

file_create Prj.file => Prj.dir do |f|
  write f.name, <<~CONTENT
    # frozen_string_literal: true

    module #{Prj.module}
      # TODO: add code here
    end
  CONTENT
end

file_create Prj.version_file => Prj.dir do |f|
  write f.name, <<~VERSION
    # frozen_string_literal: true

    module #{Prj.module}
      VERSION = '0.1.0'
    end
  VERSION
end
