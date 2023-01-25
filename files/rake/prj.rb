# frozen_string_literal: true

module Prj
  def self.name
    @name ||= (ENV['NAME'] || File.basename(Dir.pwd)).freeze
  end

  def self.module
    name.split(/[-_]/).map!(&:capitalize).join
  end

  def self.gemspec
    "#{name}.gemspec"
  end

  def self.dir
    "lib/#{name}"
  end

  def self.file
    "#{dir}.rb"
  end

  def self.version_file
    "#{dir}/version.rb"
  end
end
