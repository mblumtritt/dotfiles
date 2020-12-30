# frozen_string_literal: true

desc 'create a new Git repository'
task 'git:create', [:name] do |_, args|
  fail '🚫 name expected' unless args.name
  fail "🚫 repo already exists - #{args.name}" if Git.repo?('./' + args.name)
  sh Git.init(args.name)
  unless Git.repo?('./' + args.name)
    fail "🚫 unable to creatre repo - #{args.name}"
  end
  want "#{args.name}/.gitignore"
end

desc 'check state of a Git repository'
task 'git:check', [:name] do |_, args|
  args.with_defaults(name: '.')
  fail "🚫 not a git directory - #{args.name}" unless Git.repo?(args.name)
  puts Git.status(args.name)
end

desc 'check state of all Git repositories'
task 'git:status', [:name] do |_, args|
  args.with_defaults(name: '~/prj/my')
  Dir.glob(File.expand_path(args.name) + '/*') do |name|
    next unless Git.repo?(name)
    print(File.basename(name), ': ')
    puts Git.status(name)
  end
end

module Git
  def self.repo?(name)
    File.file?(File.join(name, '.git', 'HEAD'))
  end

  def self.init(name)
    "git init -b main \"#{name}\""
  end

  def self.status(name)
    status, result = run('git status -sb', status: true, chdir: name)
    return Parser.parse(result) if status.success?
    fail "🚫 git failed with status #{status.code} - #{result}"
  end

  class Parser
    def self.parse(lines)
      new.parse(lines)
    end

    def initialize
      @info = []
      @new_files = @changes = 0
    end

    def parse(lines)
      lines.each_line(chomp: true) { |line| parse_line(line) }
      add_new_files_info
      add_changes_info
      @info.empty? ? '✅' : @info.join(', ')
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
        @changes += 1
      end
    end

    def check_info(line)
      if line.include?('ahead')
        return @info << '‼️ needs to be merged' if line.include?('behind')
        return @info << '❗️not pushed'
      end
      @info << '⁉️  outdated' if line.include?('behind')
    end

    def add_changes_info
      return if @changes.zero?
      return @info << '⚠️  one changed file' if @changes == 1
      @info << "⚠️  #{@changes} changes"
    end

    def add_new_files_info
      return if @new_files.zero?
      return @info << '⚠️  one new file' if @new_files == 1
      @info << "⚠️  #{@new_files} new files"
    end
  end
end
