# frozen_string_literal: true

require_relative 'prj'

file_create 'stats.md' do |f|
  write f.name, <<~STATS
    # Gem/Repo Statistics

    ![version](https://img.shields.io/gem/v/#{Prj.name})
    ![downloads](https://img.shields.io/gem/dt/#{Prj.name})
    ![downloads](https://img.shields.io/gem/dtv/#{Prj.name})

    ![license](https://img.shields.io/github/license/mblumtritt/#{Prj.name})
    ![stars](https://img.shields.io/github/stars/mblumtritt/#{Prj.name})
    ![watchers](https://img.shields.io/github/watchers/mblumtritt/#{Prj.name})
    ![forks](https://img.shields.io/github/forks/mblumtritt/#{Prj.name})

    ![issues](https://img.shields.io/github/issues/mblumtritt/#{Prj.name})
    ![closed issues](https://img.shields.io/github/issues-closed/mblumtritt/#{Prj.name})
    ![pull-requests](https://img.shields.io/github/issues-pr/mblumtritt/#{Prj.name})
    ![closed pull-requests](https://img.shields.io/github/issues-pr-closed/mblumtritt/#{Prj.name})

    ![last commit](https://img.shields.io/github/last-commit/mblumtritt/#{Prj.name}/main)
    ![files](https://img.shields.io/github/directory-file-count/mblumtritt/#{Prj.name})
    ![build status](https://img.shields.io/github/workflow/status/mblumtritt/#{Prj.name}/Ruby)
    ![dependencies](https://img.shields.io/librariesio/github/mblumtritt/#{Prj.name})

    ![commit activity](https://img.shields.io/github/commit-activity/m/mblumtritt/#{Prj.name})
  STATS
end
