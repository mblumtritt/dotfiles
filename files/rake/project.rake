# frozen_string_literal: true

desc 'check state of all projects'
task 'prj:status', %w[name] do |_, args|
  args.with_defaults(name: '~/prj/my')
  require_relative 'helper/bundler'
  require_relative 'helper/git'
  Dir.glob(File.expand_path(args.name) + '/*') do |name|
    next unless File.directory?(name)
    state, missing = Dir.chdir(name){ Helper::Bundler.check(:with_missing) }
    next if state == :not_bundled
    print(File.basename(name), ': ')
    all =
      state == :gem_missing ? ["‼️  gems missing #{missing.join(', ')}"] : []
    all += Helper::Git.status(name).to_a if Helper::Git.repo?(name)
    puts(all.empty? ? '✅' : all.join(', '))
  end
end
