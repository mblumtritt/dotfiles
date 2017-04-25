My dotfiles
===================

Requirements
------------

Set zsh as your login shell:

    chsh -s $(which zsh)

Install
-------

Clone onto your laptop:

    git clone git://github.com/mblumtritt/dotfiles.git

Install [rcm](https://github.com/thoughtbot/rcm):

    brew bundle dotfiles/Brewfile

Install:

    ln -s dotfiles/rcrc ~/.rcrc
    rcup -d dotfiles

This will create a symlink for the 'rcrc' file first - which contains the default configuration. The second command creates then symlinks for config files in your home directory. The `-x` option, which exclude the `README.md` file, are needed during installation but can be skipped once the `.rcrc` configuration file is symlinked in.

You can safely run `rcup` multiple times to update:

    rcup

Make your own customizations
----------------------------

Put your customizations in dotfiles appended with `.local`:

* `~/.aliases.local`
* `~/.zshrc.local`
* `~/.gitconfig.local`
