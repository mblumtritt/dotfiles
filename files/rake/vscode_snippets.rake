# frozen_string_literal: true

module VSCode
  class << self
    attr_reader :snippets

    def ruby_snippets = File.join(snippets_dir, 'ruby.json')

    def snippets_dir
      @snippets_dir ||=
        File.expand_path('~/Library/Application Support/Code/User/snippets')
    end

    def add_snippets(definitions)
      definitions.keys.sort!.each do |trigger|
        desc, body = definitions[trigger]
        case body
        when nil
          snippet(trigger, desc, "#{desc} $0")
        when :func
          snippet(trigger, ".#{desc}", ".#{desc}($0)")
        when :bfunc
          snippet(trigger, ".#{desc}", ".#{desc} { $0 }")
          snippet("#{trigger}(", ".#{desc}(&)", ".#{desc}($0)")
        when :block
          snippet(trigger, "#{desc} block", ["#{desc} $0", 'end'])
        else
          snippet(trigger, desc, body)
        end
      end
    end

    private

    def snippet(trigger, desc, body)
      @snippets["🆁🆄🅱🆈 #{desc}"] = { 'prefix' => trigger, 'body' => body }
    end
  end

  @snippets = {}
end

desc 'Create VSCode Snippets'
task snippets: VSCode.ruby_snippets

file_create(VSCode.ruby_snippets => VSCode.snippets_dir) do |f|
  VSCode.snippets.clear
  require_relative 'ruby_snippets'
  VSCode.add_snippets(RUBY_SNIPPETS)
  require 'oj'
  write f.name, Oj.dump(VSCode.snippets)
end