# frozen_string_literal: true

require_relative 'prj'

file_create 'README.md' do |f|
  write f.name, <<~README
    # #{Prj.module} ![version](https://img.shields.io/gem/v/#{Prj.name}?label=)

    TODO: gem description here

    - Gem: [rubygems.org](https://rubygems.org/gems/#{Prj.name})
    - Source: [github.com](https://github.com/mblumtritt/#{Prj.name})
    - Help: [rubydoc.info](https://rubydoc.info/gems/#{Prj.name}/#{Prj.module})

    ## Description

    TODO: more here

    ## Installation

    You can install the gem in your system with

    ```shell
    gem install #{Prj.name}
    ```

    You can use [Bundler](http://gembundler.com/) to add #{Prj.module}
    to your own project:

    ```shell
    bundle add '#{Prj.name}'
    ```

    After that you only need one line of code to have everything together

    ```ruby
    require '#{Prj.name}'
    ```
  README
end
