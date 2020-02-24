#! /bin/sh

set -e

if [ "$SHELL" != "$(which zsh)" ]
then
	echo "Shell: use zsh"
	chsh -s "$(which zsh)"
fi

echo "General: xpand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

echo "General: expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

echo "General: enable TAB to select all controls in dialogs"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "General: don't save Metadata (.DS_Store) files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "General: don't save Metadata (.DS_Store) files on USB volume"
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "General: save to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo "General: save screenshots in PNG format"
defaults write com.apple.screencapture type -string "png"

echo "General: disable shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

echo "General: don’t show Dashboard as a Space"
defaults write com.apple.dock dashboard-in-overlay -bool true

echo "General: request password asap"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "Finder: show all files"
defaults write com.apple.finder AppleShowAllFiles YES

echo "Finder: automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

echo "Finder: show indicator lights for open applications"
defaults write com.apple.dock show-process-indicators -bool true

echo "Finder: allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo "Finder: show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Finder: show icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

echo "Mail: copy email addresses in short format"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo "iTerm: don’t display the annoying prompt when quitting"
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

echo "Google: allow updates only every 14 days"
defaults write com.google.Keystone.Agent checkInterval 1209600

ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport "$HOME/.usr/dotfiles/bin/airport"
