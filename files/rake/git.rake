# frozen_string_literal: true

desc 'create a new Git repository'
task :git, [:name] do |_, args|
  fail 'name expected' unless args.name
  fail "repo already exists - #{args.name}" if Git.repo?(args.name)
  sh Git.init(args.name)
  fail "unable to creatre repo - #{args.name}" unless Git.repo?(args.name)
  want "#{args.name}/.gitignore"
end

module Git
  def self.init(name)
    %(git init "#{name}")
  end

  def self.repo?(name)
    File.file?(File.join('.', name, '.git', 'HEAD'))
  end
end
