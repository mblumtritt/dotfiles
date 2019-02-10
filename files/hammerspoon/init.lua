-- The automated configuration reloader:
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.window.animationDuration = 0 -- disable animation
local hyper = {"cmd", "alt", "ctrl"}

-- Move current window centered
hs.hotkey.bind(hyper, "-", function()
	local win = hs.window.focusedWindow()
	local max = win:screen():frame()
	local f = win:frame()
	local space = (max.w / 8)
	f.x = max.x + space
	f.y = max.y
	f.w = max.w -  2 * space
	f.h = max.h
	win:setFrame(f)
end)

-- Move current window to left side
hs.hotkey.bind(hyper, "Left", function()
	local win = hs.window.focusedWindow()
	local max = win:screen():frame()
	local f = win:frame()
	f.x = max.x
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h
	win:setFrame(f)
end)

-- Mobe current windiw to right side
hs.hotkey.bind(hyper, "Right", function()
	local win = hs.window.focusedWindow()
	local max = win:screen():frame()
	local f = win:frame()
	  f.x = max.x + (max.w / 2)
	  f.y = max.y
	  f.w = max.w / 2
	  f.h = max.h
	  win:setFrame(f)
end)

-- Move current window to top half
hs.hotkey.bind(hyper, "Up", function()
	local win = hs.window.focusedWindow()
	local max = win:screen():frame()
	local f = win:frame()
	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = max.h / 2
	win:setFrame(f)
end)

-- Mobe current windiw to right side
hs.hotkey.bind(hyper, "Down", function()
	local win = hs.window.focusedWindow()
	local max = win:screen():frame()
	local f = win:frame()
	f.x = max.x
	f.y = max.y + (max.h / 2)
	f.w = max.w
	f.h = max.h / 2
	win:setFrame(f)
end)

-- Hide Hommerspoon's Dock icon
hs.dockicon.hide()
