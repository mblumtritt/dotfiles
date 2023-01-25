# frozen_string_literal: true

file_create 'spec/helper.rb' => 'spec' do |f|
  require_relative 'prj'

  write f.name, <<~HELPER
    # frozen_string_literal: true

    require 'rspec/core'
    require_relative '../lib/#{Prj.name}'

    $stdout.sync = $stderr.sync = $VERBOSE = true
    RSpec.configure(&:disable_monkey_patching!)
  HELPER
end

file_create 'spec/version_spec.rb' => 'spec/helper.rb' do |f|
  require_relative 'prj'

  write f.name, <<~SPEC
    # frozen_string_literal: true

    require_relative 'helper'

    RSpec.describe #{Prj.module}::VERSION do
      it { is_expected.to match(/^\\d+\\.\\d+\\.\\d+$/) }
    end
  SPEC
end
