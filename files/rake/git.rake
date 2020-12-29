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
  name = args.name || '.'
  fail "🚫 not a git directory - #{name}" unless Git.repo?(name)
  puts Git.status(name)
end

desc 'check state of all Git repositories'
task 'git:status', [:name] do |_, args|
  Dir.glob(File.expand_path(args.name || '~/prj/my') + '/*') do |name|
    next unless Git.repo?(name)
    print(File.basename(name), ': ')
    puts Git.status(name)
  end
end

module Git
  def self.init(name)
    "git init -b main \"#{name}\""
  end

  def self.status(name)
    status, result = run('git status -sb', status: true, chdir: name)
    unless status.success?
      fail "🚫 git failed with status #{status.code} - #{result}"
    end
    new_files = 0
    changes = 0
    ret = []
    result.each_line(chomp: true) do |line|
      case line[0]
      when '!'
        # ignore
      when '#'
        if line.include?('ahead')
          if line.include?('behind')
            ret << '‼️ needs to be merged'
          else
            ret << '❗️not pushed'
          end
        elsif line.include?('behind')
          ret << '⁉️  outdated'
        end
      when '?'
        new_files += 1
      when 'M', 'A', 'D', 'C', 'U', 'R'
        changes += 1
      end
    end
    ret << "⚠️  #{new_files} new files" if new_files.nonzero?
    ret << "⚠️  #{changes} changes" if changes.nonzero?
    ret.empty? ? '✅' : ret.join(', ')
  end

  def self.repo?(name)
    File.file?(File.join(name, '.git', 'HEAD'))
  end
end
