# frozen_string_literal: true

desc 'create a new Git repository'
task :git, [:name] do |_, args|
  name = args[:name] or fail 'name expected'
  fail "repo already exists - #{name}" if Git.repo?(name)
  sh "git init #{name}"
  fail "no such repo - #{name}" unless Git.repo?(name)
  want "#{name}/.gitignore"
end

module Git
  def self.repo?(name)
    File.file?(File.join('.', name, '.git', 'HEAD'))
  end
end
