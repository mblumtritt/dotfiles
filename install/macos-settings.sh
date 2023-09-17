#! /bin/sh

set -e

[ "$(uname -s)" = "Darwin" ] && {
  echo 'install: configure MacOS'

  # expand save panel by default
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  # expand print panel by default
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

  # enable TAB to select all controls in dialogs
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

  # save screenshots in PNG format
  defaults write com.apple.screencapture type -string "png"
  # echo disable shadow in screenshots
  defaults write com.apple.screencapture disable-shadow -bool true

  # request password asap
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0

  # opening and closing window animations
  defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
  # increase window resize speed for Cocoa applications
  defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

  # show all files in Finder
  defaults write com.apple.finder AppleShowAllFiles YES

  # allow text selection in Quick Look
  defaults write com.apple.finder QLEnableTextSelection -bool true

  # show status bar in Finder
  defaults write com.apple.finder ShowStatusBar -bool true

  # automatically hide and show the Dock
  defaults write com.apple.dock autohide -bool true

  # show icons for hard drives, servers, and removable media on the desktop
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

  # copy email addresses in short format in Mail
  defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

  # show the ~/Library folder
  chflags nohidden "$HOME/Library"

  [ -f "$HOME/bin/airport" ] || ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport "$HOME/bin"

  for app in Finder Dock SystemUIServer; do killall "$app" > /dev/null 2>&1; done
}
