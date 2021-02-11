# frozen_string_literal: true

desc 'create a new Git repository'
task 'git:create', [:name] do |_, args|
  fail '🚫 name expected' unless args.name
  require_relative 'helper/git'
  if Helper::Git.repo?('./' + args.name)
    fail "🚫 repo already exists - #{args.name}"
  end
  sh Helper::Git.init(args.name)
  unless Helper::Git.repo?('./' + args.name)
    fail "🚫 unable to creatre repo - #{args.name}"
  end
  want "#{args.name}/.gitignore"
end

desc 'check state of a Git repository'
task 'git:check', [:name] do |_, args|
  args.with_defaults(name: '.')
  require_relative 'helper/git'
  unless Helper::Git.repo?(args.name)
    fail "🚫 not a git directory - #{args.name}"
  end
  status = Helper::Git.status(args.name)
  if status.is_a?(Integer)
    fail("🚫 git failed with error #{status} - #{result}")
  end
  puts(status)
end

desc 'check state of all Git repositories'
task 'git:status', [:name] do |_, args|
  args.with_defaults(name: '~/prj/my')
  require_relative 'helper/git'
  Dir.glob(File.expand_path(args.name) + '/*') do |name|
    next unless Helper::Git.repo?(name)
    print(File.basename(name), ': ')
    puts Helper::Git.status(name)
  end
end
