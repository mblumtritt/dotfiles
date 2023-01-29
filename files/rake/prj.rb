# frozen_string_literal: true

module Prj
  def self.name = @name ||= (ENV['NAME'] || File.basename(Dir.pwd)).freeze
  def self.module = @module ||= name.split(/[-_]/).map!(&:capitalize).join
end
