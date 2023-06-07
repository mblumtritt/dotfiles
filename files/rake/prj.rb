# frozen_string_literal: true

module Prj
  @name = (ENV['NAME'] || File.basename(Dir.pwd)).freeze
  @module = @name.split(/[-_]/).map!(&:capitalize).join
  class << self
    attr_reader :name, :module
  end
end
