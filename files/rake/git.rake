# frozen_string_literal: true

desc 'create a new Git repository'
task :git, [:name] do |t, args|
  name = args[:name] or fail 'name expected'
  sh "git init #{name}"
  Git.check_repo(name)
  want "#{name}/.gitignore"
end

module Git
  def self.repo?(name)
    File.file?(File.join('.', name, '.git', 'HEAD'))
  end

  def self.check_repo(name)
    fail "no such repo - #{name}" unless repo?(name)
  end
end
