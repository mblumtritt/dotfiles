require_relative 'runner'

module Helper
  module Bundler
    extend Runner

    def self.bundled?
      check != :not_bundled
    end

    def self.check(include_missing = false)
      state, lines = run('bundler check', status: true)
      state = MAP_CHECK_STATE[state.exitstatus]
      return state if !include_missing || :gem_missing != state
      [state, gems_of(lines)]
    end

    private_class_method def self.gems_of(lines)
      lines
        .each_line(chomp: true)
        .filter_map do |line|
          line.delete_prefix(' * ') if line.start_with?(' * ')
        end
    end

    MAP_CHECK_STATE =
      {
        0 => :ok,
        1 => :gem_missing,
        7 => :gem_missing,
        10 => :not_bundled
      }.compare_by_identity.tap { |h| h.default = :unknown }
  end
end
