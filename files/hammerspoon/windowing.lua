hs.window.animationDuration = 0 -- disable animation

function pos_focusedWindow(fn)
	local win = hs.window.focusedWindow()
	local max = win:screen():frame()
	local f = win:frame()
	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = max.h
	fn(f, max)
	win:setFrame(f)
end

function pos_center_big(f, max)
	local space = (max.w / 8)
	f.x = max.x + space
	f.w = max.w -  2 * space
end

function pos_center_small(f, max)
	local space = (max.w / 5)
	f.x = max.x + space
	f.w = max.w - 2 * space
end

function pos_left(f, max)
	f.w = max.w / 2
end

function pos_left_min(f, max)
	f.w = max.w / 6
end

function pos_right(f, max)
	f.w = max.w / 2
	f.x = max.x + f.w
end

function pos_up(f, max)
	f.h = max.h / 2
end

function pos_down(f, max)
	f.h = max.h / 2
	f.y = max.y + f.h
end

local hyper = {"cmd", "alt", "ctrl"}

hs.hotkey.bind(hyper, "-", function() pos_focusedWindow(pos_center_big) end)
hs.hotkey.bind(hyper, ".", function() pos_focusedWindow(pos_center_small) end)
hs.hotkey.bind(hyper, "m", function() pos_focusedWindow(pos_left_min) end)
hs.hotkey.bind(hyper, "Left", function() pos_focusedWindow(pos_left) end)
hs.hotkey.bind(hyper, "Right", function() pos_focusedWindow(pos_right) end)
hs.hotkey.bind(hyper, "Up", function() pos_focusedWindow(pos_up) end)
hs.hotkey.bind(hyper, "Down", function() pos_focusedWindow(pos_down) end)
