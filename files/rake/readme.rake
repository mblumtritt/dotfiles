# frozen_string_literal: true

file_create 'README.md' do |f|
  require_relative 'prj'

  write f.name, <<~README
    # #{Prj.module} ![version](https://img.shields.io/gem/v/#{Prj.name}?label=)

    TODO: gem description here

    - Gem: [rubygems.org](https://rubygems.org/gems/#{Prj.name})
    - Source: [github.com](https://github.com/mblumtritt/#{Prj.name})
    - Help: [rubydoc.info](https://rubydoc.info/gems/#{Prj.name}/#{Prj.module})

    ## Description

    TODO: more here

    ## Installation

    Use [Bundler](http://gembundler.com/) to add #{Prj.module} in your own project:

    Include in your `Gemfile`:

    ```ruby
    gem '#{Prj.name}'
    ```

    and install it by running Bundler:

    ```bash
    bundle
    ```

    To install the gem globally use:

    ```bash
    gem install #{Prj.name}
    ```

    After that you need only a single line of code in your project to have it on board:

    ```ruby
    require '#{Prj.name}'
    ```
  README
end
