# frozen_string_literal: true

require_relative 'runner'

module Helper
  module Git
    extend Runner

    def self.repo?(name)
      File.file?(File.join(name, '.git', 'HEAD'))
    end

    def self.init(name)
      "git init -b main \"#{name}\""
    end

    def self.status(name)
      status, result = run('git status -sb', status: true, chdir: name)
      status.success? ? Status.parse(result) : status.exitstatus
    end

    class Status
      def self.parse(lines)
        new.parse(lines)
      end

      attr_reader :state, :new_files, :changed_files

      def initialize
        @state = :ok
        @new_files = @changed_files = 0
      end

      def ok?
        @state == :ok && @new_files.zero? && @changed_files.zero?
      end

      def parse(lines)
        lines.each_line(chomp: true) { |line| parse_line(line) }
        self
      end

      def to_a
        [STATE_MAP[@state], new_files_to_s, changed_files_to_s].compact
      end

      def to_s
        to_a.then { |ret| ret.empty? ? '✅' : ret.join(', ') }
      end

      private

      def parse_line(line)
        case line[0]
        when '!'
          return
        when '#'
          check_info(line)
        when '?'
          @new_files += 1
        when 'M', 'A', 'D', 'C', 'U', 'R'
          @changed_files += 1
        end
      end

      def check_info(line)
        if line.include?('ahead')
          @state = line.include?('behind') ? :not_merged : :not_pushed
        else
          @state = :outdated if line.include?('behind')
        end
      end

      STATE_MAP = {
        not_merged: '‼️ needs to be merged',
        not_pushed: '❗️not pushed',
        outdated: '⁉️  outdated'
      }.freeze

      def new_files_to_s
        return '⚠️  one new file' if @new_files == 1
        return "⚠️  #{@new_files} new files" if @new_files > 1
      end

      def changed_files_to_s
        return '⚠️  one changed file' if @changed_files == 1
        return "⚠️  #{@changed_files} changes" if @changed_files > 1
      end
    end
  end
end
