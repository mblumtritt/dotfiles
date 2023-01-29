# frozen_string_literal: true

require_relative 'prj'

directory 'spec'
directory "spec/#{Prj.name}"

file_create 'spec/helper.rb' => 'spec' do |f|
  write f.name, <<~HELPER
    # frozen_string_literal: true

    require 'rspec/core'
    require_relative '../lib/#{Prj.name}'

    $stdout.sync = $stderr.sync = $VERBOSE = true
    RSpec.configure(&:disable_monkey_patching!)
  HELPER
end

file_create(
  "spec/#{Prj.name}/version_spec.rb" => %W[spec/helper.rb spec/#{Prj.name}]
) { |f| write f.name, <<~SPEC }
  # frozen_string_literal: true

  require_relative '../helper'

  RSpec.describe #{Prj.module}::VERSION do
    it { is_expected.to match(/^\\d+\\.\\d+\\.\\d+$/) }
  end
SPEC

file_create(
  "spec/#{Prj.name}/#{Prj.name}_spec.rb" => %W[spec/helper.rb spec/#{Prj.name}]
) { |f| write f.name, <<~SPEC }
  # frozen_string_literal: true

  require_relative '../helper'

  RSpec.xdescribe #{Prj.module} do
    xit do
      # TODO: describe your module here
    end
  end
SPEC
